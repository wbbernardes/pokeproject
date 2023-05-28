# Pokémon App

## Overview

This Pokemon App provides a simple interface with a view details, including Pokemon information and their evolutionary chain, with a filter by name.

The app uses the PokeAPI for data and implements an architecture based on MVVM with clean Swift and SwiftUI for UI. It uses Combine for handling asynchronous events and Kingfisher for image caching.

## Features

- List of Pokémon with their respective images and IDs.
- Detailed view for each Pokémon displaying species and evolution chain.
- Search by name functionality.
- Pagination implemented with infinite scrolling.
- Asynchronous image loading with caching.

## Architecture

The app follows MVVM (Model-View-ViewModel) architecture with additional layers for better separation of concerns:

- **View:** Contains SwiftUI views. The views observe the ViewModel and update accordingly.
- **ViewModel:** Wraps the Model data and prepares it for use by the View. It also handles user inputs.
- **Factory :** Contains methods used to instantiate the ViewModel with required dependencies.
- **Use Case:** Contains business logic related to specific use cases.
- **Repository:** Acts as a data source for the UseCase layer and abstracts the data source from the rest of the app.
- **API Layer:** Handles API calls and responses.

#### Representation diagram:
![preview](./diagram.pdf)

## Installation

Clone the repository:

```bash
git clone https://github.com/wbbernardes/pokeproject.git
```
Now you can run the project on your iOS simulator or a physical device running iOS 15.0 or later.

## License 

### MIT
