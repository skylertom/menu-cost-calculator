# README

Figure out how to best store "prepped items"

- Probably want to tie to `Ingredient` at some point
- Right now it's included in as an `InventoryItem` (both in the databse and in the excel sheets)

Things you may want to cover:

- Ruby version

  - 2.3.3
  - Move to 2.6?

- System dependencies

* Options for Measurement conversions
  - https://github.com/Shopify/measured (has comparison of other libraries)
  - https://github.com/olbrich/ruby-units
  - **https://github.com/joshwlewis/unitwise** - currently in use
* Admin tools
  - https://github.com/thoughtbot/administrate
* Excel Reader
  - https://github.com/pythonicrubyist/creek
    - https://infinum.co/the-capsized-eight/how-to-efficiently-process-large-excel-files-using-ruby
  - Alternative: https://github.com/weshatheleopard/rubyXL
  - Use something with stream abilities for memory/efficiency
* ActiveRecord
  - https://github.com/zdennis/activerecord-import - bulk activerecord imports

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
