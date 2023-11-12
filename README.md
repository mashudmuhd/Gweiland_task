# gweiland_task

A new Flutter project.

## Getting Started

## Crypto App Project Readme
#   Overview
This Flutter project is a cryptocurrency tracking application that provides users with information about various cryptocurrencies. The project follows the MVVM (Model-View-ViewModel) architecture and utilizes dependency injection for managing dependencies. The application fetches cryptocurrency data from an API and displays it in a user-friendly interface.

# Project Structure
- The project is organized into several key components:

- api_services: This directory contains the ApiServices class, which handles communication with the external API to fetch cryptocurrency data.

- data/models: Here, you can find the data models used in the application, including CryptoModel for general cryptocurrency information and CryptoDetailModel for detailed information, such as logos.

- presentation/screens: The main user interface components are stored here. The CryptoListView is the primary screen that displays a list of cryptocurrencies. It also contains the logic for sorting and filtering the displayed data.

- presentation/view_models: The CryptoViewModel is responsible for managing the state and business logic related to the CryptoListView. It communicates with the CryptoRepository to fetch data.

- resources: This directory includes various managers for handling assets, colors, strings, styles, and values used throughout the application.

- services/repository: The CryptoRepository class acts as an intermediary between the API services and the view model. It handles data retrieval and conversion.

- main.dart: The entry point of the application sets up the provider for state management and initializes the main app widget.

# Architecture
- The project follows the MVVM architecture pattern:

- Model: Represents the data and business logic. In this project, it includes the data models (CryptoModel and CryptoDetailModel), as well as the repository (CryptoRepository).

- View: Represents the user interface. The CryptoListView is responsible for rendering the UI and interacting with the user.

- ViewModel: Acts as a mediator between the model and the view. The CryptoViewModel manages the state and business logic for the CryptoListView.

# Dependency Injection
- The project uses dependency injection to manage dependencies and make the code more modular and testable. The CryptoRepository is injected into the CryptoViewModel, and the CryptoViewModel is injected into the CryptoListView.

- This project is a starting point for a Flutter application.

- A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
