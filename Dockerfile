FROM node:alpine
ENV NODE_ENV=production

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

COPY . /srv/app

WORKDIR /srv/app

RUN NODE_ENV=development yarn && \
yarn build && rm -rf node_modules && \
yarn --prod && \
yarn cache clean && \
find ./node_modules -type f  \( -iname \*.d.ts -o -iname \*.js.map -o -iname \*.txt -o -iname \*.flow -o -iname \*.md -o -iname \*.test.js -o -iname \*.spec.js \) -delete

# Server run on 80
CMD node lib/index.js