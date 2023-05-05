# Application mobile météo

Cette application mobile a été développée avec Flutter et suit une architecture inspirée de l'article "Clean Architecture - DDD for my Flutter, Spring and React projects" de Maxime F. Les fonctionnalités principales de l'application comprennent la localisation de l'utilisateur, la recherche de lieux et la récupération de la météo en fonction d'une position (latitude, longitude), avec des informations telles que les températures actuelle, la vitesse et la direction du vent, l'humidité, etc

## Pages et navigation

L'application comporte deux pages et une barre de navigation, qui utilise le style de la NavigationBar de Material 3. La première page affiche la météo par rapport à la position actuelle de l'utilisateur, tandis que la seconde page permet de chercher, grâce à deux champs un d’autocomplétion
de lieu et un de sélection du jour), les données de la météo.

## Architecture

L'architecture de l'application suit l'approche Clean Architecture inspirée de l'article de Maxime F. Cette architecture permet de maintenir une séparation claire entre les différentes couches de l'application, en facilitant la modification et l'ajout de fonctionnalités. Le projet utilise également les bibliothèques tierces get_it et auto_route pour l'injection de dépendances et la navigation.

## Dépendances

- **auto_route**: permet de générer des routes nommées de manière plus facile et avec une meilleure performance que la navigation par défaut de Flutter.

- **flex_color_scheme**: fournit une manière simple et personnalisable de définir un thème pour l'application.

- **flutter_mapbox_autocomplete**: permet d'utiliser le service d'autocomplétion de Mapbox pour la recherche de lieux.

- **geolocator**: fournit une interface pour la récupération de la position de l'appareil de l'utilisateur.

- **get_it**: permet l'injection de dépendances et de fournir un singleton pour chaque instance de classe.

- **http**: permet de faire des requêtes HTTP vers l'API open-meteo.com.

- **provider**: permet de gérer les états de l'application de manière plus efficace et maintenable.

## Tests

L'application comporte des tests unitaires pour les différentes fonctionnalités, ainsi que des tests de widgets pour les différents composants et interfaces. Ces tests ont été mis en place pour garantir la stabilité et la fiabilité de l'application.
