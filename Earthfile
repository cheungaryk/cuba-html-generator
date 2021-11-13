ARG UI_BUNDLE_DIR_PATH=custom-ui-bundle
ARG UI_BUNDLE_ZIP_PATH=build/ui-bundle.zip

# https://docs.antora.org/antora-ui-default/set-up-project/
deps:
    FROM node:12-slim
    COPY $UI_BUNDLE_DIR_PATH ./$UI_BUNDLE_DIR_PATH
    WORKDIR $UI_BUNDLE_DIR_PATH
    RUN npm install -g gulp-cli && npm install

# https://docs.antora.org/antora-ui-default/build-preview-ui/#package-for-previewing
gulp-bundle:
    FROM +deps
    RUN gulp bundle
    SAVE ARTIFACT $UI_BUNDLE_ZIP_PATH AS LOCAL ./$UI_BUNDLE_DIR_PATH/$UI_BUNDLE_ZIP_PATH
    SAVE ARTIFACT $UI_BUNDLE_ZIP_PATH .
    
build-image:
    FROM antora/antora:2.3.4
    COPY +gulp-bundle/ui-bundle.zip /usr/local/ui-bundle.zip

    # these args are passed down from the earthly command flag `--build-arg`,
    # see the `build-image` command in Makefile for example usage.
    # For more info, see https://docs.earthly.dev/docs/earthly-command#options
    ARG date
    ARG image

    ENV today=$date
    SAVE IMAGE $image
