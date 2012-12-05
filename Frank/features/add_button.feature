Feature:
	As a developer
	I want to include a button to add a new tile to a dashable scren
	So that the users can use the core functionality of the application

	Scenario:
		Given I launch the app using iOS 6.0 and the ipad simulator
		Given the device is in landscape orientation
		Then I should see a nonhidden button marked "Add"

	Scenario:
		Given I launch the app using iOS 6.0 and the ipad simulator
		When I touch the button marked "Add"
		Then I should see a navigation bar titled "Add New Tile"