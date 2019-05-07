require 'activerecord-import/base'
# load the appropriate database adapter (postgresql, mysql2, sqlite3, etc)
require 'activerecord-import/active_record/adapters/postgresql_adapter'

class InventoryReader < ApplicationService
  def initialize(file_path)
		@file_path = file_path
    @records = []
    @counter = 0
  end

  BATCH_IMPORT_SIZE = 1000

	# eventually use activerecord_import for speed/efficiency
  def call
		rows.each do |row|
      increment_counter
      records << build_new_record(row) unless skip_row?(row)
      import_records if reached_batch_import_size? || reached_end_of_file?
    end
  end

  private

  attr_reader :file_path, :records
	attr_accessor :counter
	
  def book
    @book ||= Creek::Book.new(file_path)
  end

  # Assume content is in the second Excel sheet
  def rows
    @rows ||= book.sheets.second.simple_rows
  end

  def increment_counter
    @counter += 1
  end

  def row_count
    @row_count ||= rows.count
  end

  def build_new_record(row)
		InventoryItem.new(
			input_title: row['B'],
			input_supplier: row['A'],
			amount_unit: row['D'],
			amount_value: row['C'],
			total_cost: row['E']
		)
  end

	def import_records
    # save multiple records using activerecord-import gem
    InventoryItem.import(records)

    # clear records array
    records.clear
  end

  def reached_batch_import_size?
    (@counter % BATCH_IMPORT_SIZE).zero?
  end

  def reached_end_of_file?
    @counter == row_count
	end
	
	def skip_row?(row)
		if @counter == 1 # skip header
			true
		else
			row['A'].blank? || row['B'].blank? || row['C'].blank? || 
				row['D'].blank? || row['E'].blank? 
		end
	end
end
