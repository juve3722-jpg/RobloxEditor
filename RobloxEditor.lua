local MarketplaceService = game:GetService("MarketplaceService")

local developerProducts = MarketplaceService:GetDeveloperProductsAsync():GetCurrentPage()

for _, developerProduct in pairs(developerProducts) do
	for field, value in pairs(developerProduct) do
		print(field .. ": " .. value)
	end
	print(" ")
end
