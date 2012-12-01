Feature:
	As a developer
	I want to include the title of the application in the navigation bar
	To make it clear to users what they are using

	Scenario:
		Given I launch the app using iOS 6.0 and the ipad simulator
		Given the device is in landscape orientation
		Then I should see a navigation bar titled "Dashable"
