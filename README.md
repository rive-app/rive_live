# Rive Live

This project is used during our [Rive livestreams](https://www.youtube.com/@Rive_app/streams) as a fun way for viewers to remotely interact with us. These apps make it possible to trigger interactive Rive animations that overlay on the streamer’s video feed.

The project is divided into three parts:

- A macOS client application used by the streamer to configure and overlay animations
- A website where viewers can remotely trigger interactions for specific streamers
- The web server responsible for handling communication between the web and macOS app.

See this video for an overview of the application, as well as instructions to configure your streaming setup: TODO VID

You can create a variety of different applications with Rive for livestreams or broadcasts. This project can serve as a starting point and you're free to use it.

## Development

[Flutter](https://flutter.dev/) is used for the web and macOS app, and [Dart Frog](https://dartfrog.vgv.dev/) is used for the web server. This project makes use of the [Rive Flutter package](https://help.rive.app/runtimes/overview/flutter) to play back Rive animations. See our [runtime documentation](https://help.rive.app/runtimes/overview) for information on how to integrate [Rive](http://rive.app) for various platforms/runtimes.

### Project Structure

The macOS and Web apps are located in the `apps` folder, the web server in the `network` folder, and shared Dart code lives in the `packages` directory.

### Running Locally

> ℹ️ At least **Flutter v3.10** and **Dart v3** is required. Run: `flutter channel stable` and `flutter upgrade`.

Steps to run the applications and server locally:

1. Make sure you have [Flutter installed](https://docs.flutter.dev/get-started/install) and working.
2. Install/Update [Dart Frog](https://dartfrog.vgv.dev/): `dart pub global activate dart_frog_cli`
3. Clone this repository: `git clone https://github.com/rive-app/rive_live`
4. `cd rive_live`
5. Run everything locally: `make run_local_all`

This may take a while, especially the first time. Wait until the macOS app and web app is launched.

If you need to run the apps separately, or from a unique terminal, take a look at the `Makefile` for additional commands. Examples:

- Run **web server**: `make run_local_web_server`
- Run **macOS app**: `make run_local_overlay_app`
- Run **web app** `make run_local_web_app`

### Build and Deploy

1. Build the web server: `cd network && dart_frog build`
2. See the Dart Frog [deploy documentation](https://dartfrog.vgv.dev/docs/category/deploy) for instructions and deploy to your preferred provider
3. Create a `config.json` (project root) and add the deployed URL

```json
{
    "BASE_URL": "wss://YOUR-URL"
}
```

1. To run locally using deployed URL: `make run_prod_web_app` and `make  run_prod_overlay_app` 
2. To build: `make build_overlay_app` and `make build_web_app`
3. Distribute/Host the macOS and web app. You can 

All of the commands live in the ****************Makefile**************** if you want to run them directly. For convenience you can also run `make clean_and_build_all`.

### Local Storage
The Rive Live overlay app makes use of [Isar](https://isar.dev) to persist the configured Rive animation data. This package requires [code generation](https://isar.dev/tutorials/quickstart.html#_3-run-code-generator) when updating the storage models:
- `apps/rive_overlay_app/lib/models/animations_data.dart`
