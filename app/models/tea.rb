class Tea < ActiveRecord::Base
  	belongs_to :user
  	belongs_to :tea_type
  	has_and_belongs_to_many :atts
	validates :name, presence: true
	validates :stock, presence: true
	validates :tea_type_id, presence: true
	validates :user_id, presence: true
	strip_attributes

	def self.search(search, user_id)
		
		@tea = Tea.select("teas.name,teas.id").where('teas.stock' => 'In',  'teas.user_id' => user_id)
		
		if !search[:tea_type_id].blank?
			@tea = @tea.where(tea_type_id: search[:tea_type_id])
		end
		
		if !search[:att_id].blank?
			@tea = @tea.joins("INNER JOIN atts_teas ON teas.id = atts_teas.tea_id").where('atts_teas.att_id' => search[:att_id])
		end

		@tea = @tea.group("teas.name,teas.id").order("random()").first
	end

	def self.teaSort(searchParams, sortType, user_id)
		
		@teas = Tea.select("*").where("user_id = ?", user_id)

		if searchParams[:sort].blank?
			@teas = @teas.all
		else			
			@teas = @teas.order("#{searchParams[:sort]} #{sortType}")
		end

	end
end
