require_relative '../lib/scrapping_script.rb'

describe "connection" do
	it "Did the connection performed ?" do
		expect(open_html).not_to be_nil
	end
end

describe "nature of data" do
	it "is the last table an array ?" do
		expect(create_names_array(open_html).class).to eq(Array)
	end

	it "is the $ deleted ?" do
		expect(remove_usd_symbol(create_prices_array(open_html)).class).not_to eq(String)
	end
end