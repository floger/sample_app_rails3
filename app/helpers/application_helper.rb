module ApplicationHelper
	# Return a title on a per-page basis.
	def title
		base_tile = "Ruby on Rails Tutorial Sample App"
		if @title.nil?
			base_tile
		else
			"#{base_tile} | #{@title}"
		end
		
	end
end
