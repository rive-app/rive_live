# RUN LOCAL - Run apps locally, pointing to localhost
run_local_all:
	make run_local_web_server & make run_local_web_app & make run_local_overlay_app

run_local_web_server:
	cd network && dart_frog dev

run_local_web_app:
	cd apps/rive_live_webapp/ && flutter run -d chrome

run_local_overlay_app:
	cd apps/rive_overlay_app/ && flutter run -d macos 

# RUN PROD - Run apps locally, pointing to prod
run_prod_web_app:
	cd apps/rive_live_webapp/ && flutter run -d chrome --dart-define-from-file=../../config.json

run_prod_overlay_app:
	cd apps/rive_overlay_app/ && flutter run -d macos --dart-define-from-file=../../config.json

# BUILD
clean_and_build_all:
	make clean_all
	make build_all

build_all:
	make build_web_app
	make build_overlay_app
	make build_webserver

build_webserver:
	cd network && dart_frog build

build_overlay_app:
	cd apps/rive_overlay_app/ && flutter build macos --dart-define-from-file=../../config.json

build_web_app:
	cd apps/rive_live_webapp/ && flutter build web --dart-define-from-file=../../config.json

#CLEAN
clean_all:
	make clean_web_app
	make clean_overlay_app

clean_overlay_app:
	cd apps/rive_overlay_app/ && flutter clean && flutter pub get

clean_web_app:
	cd apps/rive_live_webapp/ && flutter clean && flutter pub get