require 'spec_helper'
require 'purchase_order'

RSpec.describe PurchaseOrder do

  describe "creating a purchase order" do
    it "should ouput a purchase order .iif file identical to the example" do
      #original_file_name = '/Users/blaed/Downloads/IIF Import Kit/IIF Example Files/QB 2007 & Enterprise 7.0 and later/Purchase Order (AP non-posting)/2007 Purchase Order.iif'
      po_date = "02/16/2015"
      attrs = {
        date: po_date,
        total: '-17',
        po_number: 342,
        memo: "testmemo #{DateTime.now}",
        line_items: [
          {
            splid: 34,
            date: po_date,
            amount: 3,
            qnty: 2,
            price: 1.5,
            part_description: 'part number 101',
            part_num: '101'
          } ,
          {
            splid: 33,
            date: po_date,
            amount: 14,
            qnty: 2,
            price: 7,
            part_description: 'part number 102',
            part_num: '102'
          }
        ]
      }
      @po = PurchaseOrder.new
      @po.ouput_po('testfile.iif', attrs)
      constant_file_content = IO.read('purchord.iif')
      testfile = IO.read('testfile.iif')
      expect(testfile).not_to eql ""
    end
  end
end
