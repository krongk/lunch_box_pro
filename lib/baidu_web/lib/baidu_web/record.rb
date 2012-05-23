module BaiduWeb
  class Record
  	attr_accessor :title, :url, :summary, :updated_date, :item_index, :size, :cached_url
  end
end

# Store the item of search result.
# :title
# 	Returns the matched web page or document's page title.
# :url
# 	Returns the absolute URL for the matched web document.
# :summary
# 	A brief summary for the matched web document from Baidu.com
# :date
# 	Return the searched date.
# :page_index
# 	Return the record of the pagination, started with 1.
# :item_index
# 	Return the record index in the search result page, started with 1.
# :size
# 	Size info for the matched document. Note that it's not an number, instead it's in the form of '32K' or something like that.
# :cached_url
# 	Returns the url pointing to the cached version of the matched document on Baidu.com. Note that, for documents with types like DOC, PPT and XSL, there won't be a cached version. So this property always returns undef in these cases.
# 	