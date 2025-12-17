COPY staging.sales_orders
FROM 's3://{{ S3_BUCKET }}/sales_overtime/'
IAM_ROLE '{{ REDSHIFT_IAM_ROLE }}'
FORMAT AS CSV
IGNOREHEADER 1
DELIMITER ',';

COPY staging.sales_order_items
FROM 's3://{{ S3_BUCKET }}/sales_order_items/'
IAM_ROLE '{{ REDSHIFT_IAM_ROLE }}'
FORMAT AS CSV
IGNOREHEADER 1
DELIMITER ',';

COPY staging.inventory
FROM 's3://{{ S3_BUCKET }}/inventory/'
IAM_ROLE '{{ REDSHIFT_IAM_ROLE }}'
FORMAT AS CSV
IGNOREHEADER 1
DELIMITER ',';

COPY staging.products
FROM 's3://{{ S3_BUCKET }}/products/'
IAM_ROLE '{{ REDSHIFT_IAM_ROLE }}'
FORMAT AS CSV
IGNOREHEADER 1
DELIMITER ',';

COPY staging.warehouses
FROM 's3://{{ S3_BUCKET }}/warehouses/'
IAM_ROLE '{{ REDSHIFT_IAM_ROLE }}'
FORMAT AS CSV
IGNOREHEADER 1
DELIMITER ',';