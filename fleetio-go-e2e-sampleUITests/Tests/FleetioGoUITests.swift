//
//  fleetio_go_e2e_sampleUITests.swift
//  fleetio-go-e2e-sampleUITests
//
//  Created by Tony Fang on 7/19/24.
//

import XCTest

final class FleetioGoUITests: FleetioGoUITestsBaseClass {
    
    var homeScreen: HomeScreen!
    var browseScreen: BrowseScreen!
    var vehiclesScreen: VehiclesScreen!
    var vehicleDetailsScreen: VehicleDetailsScreen!
    var vehicleFuelLogScreen: VehicleFuelLogScreen!
    var addFuelLogScreen: AddFuelLogScreen!
    
    var fuelEntryCountInitial: Int = 0
    var fuelEntryCountAfterAdd: Int = 0
        
    override func setUp() {
        continueAfterFailure = false
        app.launch()
        LoginScreen().verifyLoginFields()
        homeScreen = LoginScreen().login()
    }
        
    func testAddNewFuelEntryForExistingVehicle() {
        homeScreen.verifyHomeImage()
        
        browseScreen = homeScreen.tapBrowserTab()
        
        browseScreen.verifyVehiclesButton()
        
        vehiclesScreen = browseScreen.tapVehicles()
        
        vehicleDetailsScreen = vehiclesScreen.selectVehicleName(vehicleName: "Electric Dream")
        
        vehicleFuelLogScreen = vehicleDetailsScreen.tapFuelLog()
        
        fuelEntryCountInitial = vehicleFuelLogScreen.getFuelEntryCount()
        
        addFuelLogScreen = vehicleFuelLogScreen.tapAddNewFuelLogButton()
        
        addFuelLogScreen = addFuelLogScreen.fillAddNewFuelFields()
        
        vehicleFuelLogScreen = addFuelLogScreen.saveNewFuelEntry()
        
        fuelEntryCountAfterAdd = vehicleFuelLogScreen.getFuelEntryCount()
        
        // The fuel entry count should be increased by 1 after save
        XCTAssertEqual(fuelEntryCountAfterAdd, fuelEntryCountInitial + 1)
    }
    
    func testRequiredFieldsNotFilledNewFuelEntry() {
        homeScreen.verifyHomeImage()
        
        browseScreen = homeScreen.tapBrowserTab()
        
        browseScreen.verifyVehiclesButton()
        
        vehiclesScreen = browseScreen.tapVehicles()
        
        vehicleDetailsScreen = vehiclesScreen.selectVehicleName(vehicleName: "Electric Dream")
        
        vehicleFuelLogScreen = vehicleDetailsScreen.tapFuelLog()
        
        addFuelLogScreen = vehicleFuelLogScreen.tapAddNewFuelLogButton()
        
        addFuelLogScreen.saveNewFuelEntryWithoutFillingRequiredFields()
        
    }
    
    
    override func tearDown() {
        let screenshot = XCUIScreen.main.screenshot()
        let attach = XCTAttachment(screenshot: screenshot)
        add(attach)
    }
}