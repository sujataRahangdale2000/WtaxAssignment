import { LightningElement,track,wire} from 'lwc';
import getCities from '@salesforce/apex/GetWeatherDataController.returnCities';

import getForecast from '@salesforce/apex/GetWeatherDataController.getForecast';
export default class WeatherDataComponent extends LightningElement {

    cityOptions = [];
    selectedCity;
    selectedDate;
    @track forecastData = [];

    columns = [
        { label: 'Time', fieldName: 'reqtime' },
        { label: 'Temperature (°C)', fieldName: 'temperature' }
    ];

    @wire(getCities)
    cities({ data }) {
        if(data) {
            console.log('data>>>>',JSON.stringify(data));
            console.log('first record', data[0]);
            console.log('name', data[0].Name);
            this.cityOptions = data.map(city => ({
                label: city.Name,
                value: city.Id
            }));
        }
    }

    handleCity(event) {
        this.selectedCity = event.detail.value;
    }

    handleDate(event) {
        this.selectedDate = event.target.value;
    }

    getWeather() {

        getForecast({
            cityId: this.selectedCity,
            selectedDate: this.selectedDate
        })
        .then(result => {
            this.forecastData = result;
        })
        .catch(error => {
            console.error(error);
        });
    }
}