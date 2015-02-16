require 'riif'

class PurchaseOrder
  attr_accessor :date

  TRANSACTION_TYPE = "PURCHORD"
  ACCOUNT = "Purchase Orders"
  INCOME_ACCOUNT = "Construction Income"
  VENDOR_NAME = "Dakota Supply Group"
  
  def initialize()

  end

  def ouput_po(filename, args = {})
    po = Riif::IIF.new do
      trns do
        row do
          trnsid 133790
          trnstype TRANSACTION_TYPE
          date args[:date] # date of material order
          accnt ACCOUNT
          name VENDOR_NAME
          amount args[:total] #calculated from material order, from bs_cost or dsg_cost
          docnum args[:po_number] # material order id number, 'PO Number' in qb
          memo args[:memo] # notes field of material order.
        end
        spl do # for each line_item in materials order
          args[:line_items].each do |li| 
            row do
              splid li[:splid]
              trnstype TRANSACTION_TYPE
              date li[:date]
              accnt INCOME_ACCOUNT
              amount li[:amount] #total from line item
              qnty li[:qnty] # from line_item.quantity
              price li[:price]
              memo li[:part_description] 
              invitem li[:part_num] # line_item.part_num
            end
          end
        end
      end
    end

    File.open(filename, "w") do |file|
      file.puts po.output
    end
    File.open("/Users/blaed/Dropbox/Temp/#{filename}", "w") do |file|
      file.puts po.output
    end
  end


end
