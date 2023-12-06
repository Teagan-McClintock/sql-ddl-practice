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
    model VARCHAR(25) NOT NULL,
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
    notes TEXT NOT NULL
);
