CREATE TABLE staging.sales_orders (
    customer_id     VARCHAR(20),
    order_date      DATE,
    order_id        VARCHAR(20),
    status          VARCHAR(20) NOT NULL,
    total_amount    DOUBLE PRECISION,
    PRIMARY KEY(order_id)
);

CREATE TABLE staging.sales_order_items (
    order_id       VARCHAR(20),
    order_item_id  VARCHAR(20) PRIMARY KEY,
    product_id     VARCHAR(20),
    quantity       INT,
    unit_price     DOUBLE PRECISION,
    warehouse_id   VARCHAR(20)
);

CREATE TABLE staging.inventory (
    inventory_id    VARCHAR(20) PRIMARY KEY,
    product_id      VARCHAR(20),
    warehouse_id    VARCHAR(20),
    stock_on_hand   INT,
    restock_date    DATE,
    expiry_date     DATE
);

CREATE TABLE staging.products (
    product_id      VARCHAR(20) PRIMARY KEY,
    product_name    VARCHAR(30),
    category        VARCHAR(30),
    unit_price      DOUBLE PRECISION,
    cost_price      DOUBLE PRECISION,
    perishable      BOOLEAN,
    shelf_life_days INT,
    supplier_id     VARCHAR(20)
);

CREATE TABLE staging.warehouses (
    warehouse_id    VARCHAR(10) PRIMARY KEY,
    warehouse_name  VARCHAR(30),
    location        VARCHAR(50),
    capacity        INT
);
