# install: configure

# configure:

#     @echo "⚙️ Configuring WordPress parameters..."
#     wp core install \
#         --url=${WORDPRESS_WEBSITE_URL_WITHOUT_HTTP} \
#         --title=$(WORDPRESS_WEBSITE_TITLE) \
#         --admin_user=${WORDPRESS_ADMIN_USER} \
#         --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
#         --admin_email=${WORDPRESS_ADMIN_EMAIL}

#     wp option update siteurl ${WORDPRESS_WEBSITE_URL}
#     wp rewrite structure $(WORDPRESS_WEBSITE_POST_URL_STRUCTURE)

# start:
#     docker-compose up -d --build

# healthcheck:
#     docker-compose run --rm healthcheck

# down:
#     docker-compose down

# install: start healthcheck

# configure:
#     docker-compose -f docker-compose.yml -f wp-auto-config.yml run --rm wp-auto-config

# autoinstall: start
#     docker-compose -f docker-compose.yml -f wp-auto-config.yml run --rm wp-auto-config

# clean: down
#     @echo "💥 Removing related folders/files..."
#     @rm -rf  mysql/* wordpress/*

# reset: clean