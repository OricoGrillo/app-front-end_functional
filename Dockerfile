FROM node AS builder

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN npm install
RUN $(npm bin)/ng build --prod --aot
#RUN npm run build --prod --aot


 

FROM nginx

WORKDIR /usr/share/nginx/html/

COPY --from=builder /usr/src/app/dist/app-front-end/ /usr/share/nginx/html

EXPOSE 80 443


 

CMD nginx -g 'daemon off;'