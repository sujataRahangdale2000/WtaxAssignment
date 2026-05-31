# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
# Weather Forecast Application - Salesforce LWC

## Overview

This project is a Salesforce Lightning Web Component (LWC) application that allows users to retrieve hourly weather forecast data for selected cities using the Open-Meteo Forecast API.

The application also logs every weather search performed by users and stores the search details in Salesforce for reporting and analytics purposes.

---

## Features

### User Story 1 - Weather Forecast Lookup

* Select a city from a predefined list stored in Salesforce.
* Select a forecast date (today or future date).
* Retrieve hourly temperature forecast data using the Open-Meteo API.
* Display hourly forecast information in a Lightning Datatable.
* Store city coordinates securely on the Salesforce server.

### User Story 2 - Weather Search Tracking

* Log every weather search performed by users.
* Capture:

  * User Name
  * Search Date & Time
  * Forecast Date
  * Selected City
  * Timezone returned by API
* Support Salesforce reporting and analytics on search trends.

---

## Technologies Used

* Salesforce Lightning Web Components (LWC)
* Apex
* SOQL
* Open-Meteo Forecast API
* Lightning Datatable
* Salesforce Reports

---

## Custom Objects

### City__c

Stores predefined cities and their coordinates.

| Field        | Type   |
| ------------ | ------ |
| Name         | Text   |
| Latitude__c  | Number |
| Longitude__c | Number |

### WeatherSearch__c

Stores weather search history.

| Field               | Type                |
| ------------------- | ------------------- |
| User_Name__c        | Text / Lookup(User) |
| Search_Date_Time__c | DateTime            |
| Forecast_Date__c    | Date                |
| Location__c         | Text                |
| Timezone__c         | Text                |

---

## API Used

Open-Meteo Forecast API

Endpoint:

```text
https://api.open-meteo.com/v1/forecast
```

Sample Request:

```text
https://api.open-meteo.com/v1/forecast?latitude=18.5204&longitude=73.8567&hourly=temperature_2m&start_date=2026-05-31&end_date=2026-05-31
```

No API key is required.

---

## Setup Instructions

### 1. Clone Repository

```bash
git clone https://github.com/sujataRahangdale2000/WtaxAssignment.git
```

### 2. Authorize Salesforce Org

```bash
sf org login web
```

### 3. Deploy Metadata

```bash
sf project deploy start
```

### 4. Configure Remote Site Setting

Navigate to:

Setup → Remote Site Settings → New

Values:

```text
Remote Site Name: OpenMeteo
Remote Site URL: https://api.open-meteo.com
```

### 5. Insert City Records

Create City__c records with latitude and longitude values.

Example:

| City   | Latitude | Longitude |
| ------ | -------- | --------- |
| Pune   | 18.5204  | 73.8567   |
| Mumbai | 19.0760  | 72.8777   |
| Delhi  | 28.6139  | 77.2090   |

---

## Project Flow

1. User selects city and forecast date.
2. LWC calls Apex controller.
3. Apex retrieves latitude and longitude from City__c.
4. Apex calls Open-Meteo API.
5. API returns hourly temperature forecast.
6. Apex logs the search in WeatherSearch__c.
7. Forecast data is returned to LWC.
8. Results are displayed in a Lightning Datatable.

---

## Reporting

A Salesforce Tabular or Summary Report can be created on the WeatherSearch__c object.

Suggested Columns:

* User Name
* Search Date Time
* Forecast Date
* Location
* Timezone

This enables tracking of:

* Most searched cities
* User search activity
* Forecast trends
* Timezone analysis

---

## Author

Sujata Rahangdale

GitHub Repository:

https://github.com/sujataRahangdale2000/WtaxAssignment

