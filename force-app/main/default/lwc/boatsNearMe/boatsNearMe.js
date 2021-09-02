import { api, LightningElement,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// imports
import getBoatsByLocation from '@salesforce/apex/BoatDataService.getBoatsByLocation';
const LABEL_YOU_ARE_HERE = 'You are here!';
const ICON_STANDARD_USER = 'standard:user';
const ERROR_TITLE = 'Error loading Boats Near Me';
const ERROR_VARIANT = 'error';
export default class BoatsNearMe extends LightningElement {
  @api
  boatTypeId;
  mapMarkers = [];
  isLoading = true;
  isRendered;
  latitude;
  longitude;
  
  // Add the wired method from the Apex Class
  // Name it getBoatsByLocation, and use latitude, longitude and boatTypeId
  // Handle the result and calls createMapMarkers
  @wire(getBoatsByLocation,{latitude:'$latitude',longitude:'$longitude',boatTypeId:'$boatTypeId'})
  wiredBoatsJSON({ error, data }) {
    if (data) {
      this.createMapMarkers(data);
      console.log('JSON String '+JSON.stringify(this.boats));
  } else
  {
      this.error = error;
      const toast = new ShowToastEvent({
        title: ERROR_TITLE,
        message: error.message,
        variant: ERROR_VARIANT,
    });
    this.dispatchEvent(toast);

  }
  this.isLoading = false;
   }
  
  // Controls the isRendered property
  // Calls getLocationFromBrowser()
  renderedCallback() { 
    if (!this.isRendered) {
      this.getLocationFromBrowser();
  }
  this.isRendered = true;

  }
  
  // Gets the location from the Browser
  // position => {latitude and longitude}
  getLocationFromBrowser() { 

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(position => {

          // Get the Latitude and Longitude from Geolocation API
          this.latitude = position.coords.latitude;
          this.longitude = position.coords.longitude;
          
          // Add Latitude and Longitude to the markers list.
          this.mapMarkers = [{
              location : {
                  Latitude: this.latitude,
                  Longitude : this.longitude
              },
              title : LABEL_YOU_ARE_HERE
          }];
          this.zoomlevel = "4";
      });
  }

  }
  
  // Creates the map markers
  createMapMarkers(boatData) {
     // const newMarkers = boatData.map(boat => {...});
     // newMarkers.unshift({...});
     const newMarkers = JSON.parse(boatData).map(boat => {
      return {
          title: boat.Name,
          location: {
              Latitude: boat.Geolocation__Latitude__s,
              Longitude: boat.Geolocation__Longitude__s
          }
            };
                });
        newMarkers.unshift({
        title: LABEL_YOU_ARE_HERE,
        icon: ICON_STANDARD_USER,
        location: {
        Latitude: this.latitude,
        Longitude: this.longitude
                   }
        });
          this.mapMarkers = newMarkers;
   }
}
