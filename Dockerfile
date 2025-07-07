FROM python:3.10

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libjpeg-dev \
    libpng-dev \
    node-less \
    npm \
    && apt-get clean

# Crear usuario odoo
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

# Copiar el código fuente
COPY ./odoo /opt/odoo

# Cambiar permisos
RUN chown -R odoo:odoo /opt/odoo

USER odoo

# Instalar dependencias Python
RUN pip install --upgrade pip
RUN pip install -r /opt/odoo/requirements.txt

# Crear carpeta para addons extra
RUN mkdir /opt/odoo/custom_addons

EXPOSE 8069

CMD ["/usr/local/bin/python", "/opt/odoo/odoo-bin", "-c", "/opt/odoo/debian/odoo.conf"]

