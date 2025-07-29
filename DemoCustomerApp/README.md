# DemoCustomersApp with Clean Architecture and SwiftUI

## Overview

  DemoCustomersApp is an iOS application designed with Clean Architecture principles and SwiftUI modularity. This project demonstrates a scalable, maintainable, and testable architecture, leveraging dependency injection, protocol-oriented programming, and clear separation of concerns.

## Project Structure

The project is organized into distinct layers, each responsible for specific concerns:

- **App**: Entry point and application lifecycle management.
- **Presentation**: UI components and view models.
- **Domain**: Business logic and use cases.
- **Data**: Data sources and repositories.
- **Infrastructure**: Configuration, network, and utilities.


## Layer Responsibilities

### App

**DemoCustomerApp.swift**: Entry point of the application, responsible for setting up the main window and initializing the dependency injection.

### Presentation

**View**: Contains SwiftUI views responsible for the UI layout and presentation.

- **CustomerListView.swift**: Main view displaying Customers information.
- **CustomerDetailView.swift**: Detail view displaying individual Customer data items.

**CustomerViewModel.swift**: Contains view models that manage UI state and interact with the domain layer.

- **CustomerDataModel.swift**: Model that holds the readable format of the recieved JSON data.

### Domain

**Interface**: Defines protocols for repositories and data sources, ensuring a clear contract between layers.

- **CustomerRepositoryFetch.swift**: Protocol definition with completion handler on fetch.
- **CustomerRepository.swift**: Protocol for data repositories.

**UseCases**: Contains business logic and application-specific rules.

- **FetchCustomerUsecase.swift**: Use case for fetching customer data.

**Entities**: Contains business models representing core domain objects.

- **CustomerModel.swift**: Domain models for customer data.

### Data

**Remote**: Contains data sources for fetching data from remote APIs.

- **RemoteDataSource.swift**: Implementation to fetch the data source using remote APIs.

**Local**: Contains data sources for fetching data from local files.

- **LocalDataSource.swift**: Implementation to fetch data source using local JSON files.

**Repositories**: Coordinates between data sources and domain layer, transforming data as needed.

- **CustomerDataSource.swift**: Implementation of data source repository.

**Model**: Model that holds the data of Data Type Object(DTO).

- **CustomerModelDTO.swift**: Holds the DTO in codable format to render the raw JSON data when recieved.

### Infrastructure

**Network**: Manages network communication details.

- **APIClient.swift**: Handles HTTP requests and responses.
- **HTTPMethod.swift**: Enum for HTTP methods.
- **APIConfiguration.swift**: Constructs URLs for API endpoints.

**Configuration**: Manages application configurations.

- **ConfigManager.swift**: Implementation of configuration protocol.

**Security**: Manages Jailbreak and URL checks.

- **SecurityChecker.swift**: Contains the logic to check the device jailbreak and processing URL check.

**Utilities**: Contains shared utilities and helpers.

- **Constants.swift**: Contains all the constant values that is declared in the application.
- **JSONLoader.swift**: Utility for loading JSON from local files.

**Protocols**: Defines protocols for infrastructure components.

- **JSONLoaderProtocol.swift**: Protocol for JSON loader.
- **APIClientProtocol.swift**: Protocol for API client.
- **ConfigurationProtocol.swift**: Protocol for configuration.

### Core

**ModuleMapper**: Contains The logic to map the fetched module.

- **CustomerDataModelMapper.swift**: Maps the secold level of detail data with the first level of data fetched.
- **CustomerModelMapper.swift**: Maps the first layer of data fetched.

## Dependency Injection

The project leverages dependency injection to manage dependencies between layers. This ensures loose coupling and enhances testability. Dependencies are injected through initializers, allowing for easy substitution of implementations during testing.

## Unit Test Cases

Unit test cases are incorporated to check the logics added are working as expected that is tested with mock data and results are compared with the set of available values and expectations.
