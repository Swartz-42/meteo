# Application mobile de météo

Cette application mobile a été développée en utilisant le framework Flutter, et elle suit une architecture inspirée de l'article "Clean Architecture - DDD for my Flutter, Spring and React projects" de Maxime F. Les principales fonctionnalités de l'application incluent la localisation de l'utilisateur, la recherche de lieux et la récupération de la météo en fonction de la position de l'utilisateur (latitude, longitude), avec des informations telles que la température actuelle, la vitesse et la direction du vent, l'humidité, etc.

## Pages et navigation

L'application se compose de deux pages et d'une barre de navigation qui utilise le style de la NavigationBar de Material 3. La première page affiche la météo actuelle par rapport à la position actuelle de l'utilisateur. La seconde page permet à l'utilisateur de chercher les données météorologiques de leur choix grâce à deux champs de saisie, un champ de saisie pour l'autocomplétion des lieux et un champ de sélection du jour.

## Architecture

L'architecture de l'application est basée sur les principes de la Clean Architecture. Elle est divisée en différentes couches, chacune étant responsable d'une tâche spécifique. Les couches sont organisées de manière à ce qu'elles soient facilement testables et maintenables.

## Dépendances

Les dépendances utilisées dans l'application incluent :

- **auto_route**: permet de générer des routes nommées de manière plus facile et avec une meilleure performance que la navigation par défaut de Flutter.

- **flex_color_scheme**: fournit une manière simple et personnalisable de définir un thème pour l'application.

- **flutter_mapbox_autocomplete**: permet d'utiliser le service d'autocomplétion de Mapbox pour la recherche de lieux.

- **geolocator**: fournit une interface pour la récupération de la position de l'appareil de l'utilisateur.

- **http**: permet de faire des requêtes HTTP vers l'API open-meteo.com.

- **provider**: permet de gérer les états de l'application de manière plus efficace et maintenable.
