CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL
);

-- TABLE BIKES
    -- code: FLY, HAUL, SKIN, BUD (primary)
    -- model:
    -- base_cost_usd: (numeric)
    --
CREATE TABLE bikes (
    code VARCHAR(4) PRIMARY KEY,
    model VARCHAR(25) NOT NULL, --UNIQUE
    base_cost_usd NUMERIC(10, 2) NOT NULL
);

-- TABLE ORDERS
    -- order_id: serial (primary)
    -- order_date:  time timezone
    -- customer_id: reference customers.id
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date TIMESTAMP WITH TIME ZONE NOT NULL,
    customer_id INT NOT NULL REFERENCES customers
);

-- BIKE_ORDER - 1 bike to 1 order (itemized)
    -- id: serial (primary)
    -- order_id: reference orders.order_id
    -- bike model: reference bike.model
    -- price: can be lower than bikes.base_cost_usd
    -- notes: "notes from bernie"
CREATE TABLE bike_order (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders,
    bike_code VARCHAR(4) NOT NULL REFERENCES bikes,
    price NUMERIC(10, 2) NOT NULL,
    notes TEXT --put NOT NULL DEFAULT '' (and maybe) CHECK NOT LIKE ' %' (or something to avoid extra whitespace)
);

INSERT INTO bikes (code, model, base_cost_usd) VALUES
    ('FLY', 'The Flyer', 500.00),
    ('HAUL', 'The Big Haul', 600.00),
    ('SKIN', 'The Skinny', 700.00),
    ('BUD', 'Big Buddy', 800.00);

INSERT INTO customers (first_name, last_name) VALUES
    ('E', 'T'),
    ('Bernie', 'Sanders');

INSERT INTO orders (order_date, customer_id) VALUES
    ('1980-12-13', 1),
    ('1982-05-30', 1),
    ('1982-06-01', 2),
    ('2020-12-13', 2);

INSERT INTO bike_order (order_id, bike_code, price, notes) VALUES
    (1, 'FLY', 500.00, 'Add basket');

INSERT INTO bike_order (order_id, bike_code, price) VALUES
    (2, 'FLY', 450.00),
    (2, 'HAUL', 540.00),
    (2, 'SKIN', 630.00),
    (2, 'BUD', 720.00),
    (3, 'SKIN', 700.00),
    (4, 'SKIN', 560.00),
    (4, 'BUD', 640.00)
    ;

SELECT order_date, c.first_name, c.last_name, b.model, bo.price
FROM orders AS o
INNER JOIN bike_order AS bo
    ON o.order_id = bo.order_id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN bikes b
    ON bo.bike_code = b.code;