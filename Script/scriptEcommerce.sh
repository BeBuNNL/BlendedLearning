# 2021 - Nguyen Nhat Linh
# Tong hop khi tim hieu OpenedX

#!/bin/bash

sed -i -e "s/ENABLE_OAUTH2_PROVIDER.*/ENABLE_OAUTH2_PROVIDER: true/" /edx/etc/lms.yml
sed -i -e "s/PAID_COURSE_REGISTRATION_CURRENCY.*/PAID_COURSE_REGISTRATION_CURRENCY: ["VND","đ"]/" /edx/etc/lms.yml
#sed -i -e "s/PDF_RECEIPT_BILLING_ADDRESS.*/PDF_RECEIPT_BILLING_ADDRESS: "Nhập địa chỉ nhận biên lai của bạn\nở đây.\n"/" /edx/etc/lms.yml
#sed -i -e "s/PDF_RECEIPT_COBRAND_LOGO_PATH.*/PDF_RECEIPT_COBRAND_LOGO_PATH: ""/" /edx/etc/lms.yml
#sed -i -e "s/PDF_RECEIPT_DISCLAIMER_TEXT.*/PDF_RECEIPT_DISCLAIMER_TEXT: ""/" /edx/etc/lms.yml
#sed -i -e "s/PDF_RECEIPT_FOOTER_TEXT.*/PDF_RECEIPT_FOOTER_TEXT: ""/" /edx/etc/lms.yml
#sed -i -e "s/PDF_RECEIPT_LOGO_PATH.*/PDF_RECEIPT_LOGO_PATH: ""/" /edx/etc/lms.yml
#sed -i -e "s/PDF_RECEIPT_TAX_ID.*/PDF_RECEIPT_TAX_ID: ""/" /edx/etc/lms.yml
#sed -i -e "s/PDF_RECEIPT_TAX_ID_LABEL.*/PDF_RECEIPT_TAX_ID_LABEL: ""/" /edx/etc/lms.yml
#sed -i -e "s/PDF_RECEIPT_TERMS_AND_CONDITIONS.*/PDF_RECEIPT_TERMS_AND_CONDITIONS: ""/" /edx/etc/lms.yml

#. provision_ida_user.sh ecommerce ecommerce 8002 ecommerce
sudo su ecommerce -s /bin/bash
cd ~/ecommerce
source ../ecommerce_env &&
python manage.py makemigrations &&
python manage.py migrate &&
python manage.py create_or_update_site \
	--site-id=1 \
	--site-domain=localhost:8002 \
	--partner-code=edX \
	--partner-name='Open edX' \
	--lms-url-root=http://localhost:80 \
	--payment-processors=paypal \
	--sso-client-id=ecommerce-sso-key \
	--sso-client-secret=ecommerce-sso-secret \
	--from-email=ecommerce_worker@example.com \
	--discovery_api_url=http://localhost:18381/ \
	--backend-service-client-id=ecommerce-backend-service-key \
	--backend-service-client-secret=ecommerce-backend-service-secret
