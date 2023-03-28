# uber_clone

clon de la app de Uber usando flutter

# Desarrollo de app en flutter

- Instalar flutter:
	https://docs.flutter.dev/get-started/install?gclid=Cj0KCQjw2v-gBhC1ARIsAOQdKY2jdvazhxdgjJrsNJGZEHJBtNojlBaGaRTEZV_gqU2squbt-DluJWoaAsRgEALw_wcB&gclsrc=aw.ds

- descargar archivo comprimido, extraer contenido y ubicar la carpeta flutter en: C:\src\flutter

- editar variables de entorno del sistema, editar path, agregar rura: C:\src\flutter\bin

- instalar git

- abrir consola de bash, dirigirse a la ruta: C:\src\flutter\bin y escribir comando: "flutter doctor" para confrmar que flutter está bien configurado

- instalar android studio

- instalar visual studio code

## Obtener sha-1 de la app  

- en la consola del proyecto digitar el siguiente comando:
	keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

## configuraciones de manifest ANDROID

-permiso de internet:
	<uses-permission android:name="android.permission.INTERNET" />

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
