# Pizzeria Database Management System

This project is a relational database management system designed for a chain of pizzerias. The database facilitates efficient management of customer data, orders, reservations, employee details, menu items, and promotions, providing a robust backend for business operations and analytics.

## Business Model Overview

The database supports a chain of pizzerias with multiple locations across various cities, allowing customers to place orders, make reservations, and receive promotions. Key entities include customers, orders, employees, menu items, and reviews. The database structure ensures data integrity through defined relationships, constraints, and normalization to streamline operations across the chain.

### Project Highlights

- **Entity and Relationship Modeling**: Developed entity-relationship diagrams (ERDs) to map out the relationships and dependencies within the business structure.
- **Database Normalization**: Ensured 3rd Normal Form (3NF) to reduce redundancy and maintain data consistency.
- **Table Creation and Constraints**: Defined primary and foreign key constraints for data integrity across tables.
- **Stored Procedures and Functions**: Added SQL procedures for key operations, such as retrieving popular pizzas per location and generating customer order summaries.
- **Sample Data Insertion**: Populated tables with sample data for testing, covering customers, orders, employees, and menu items.

### Key Database Entities

- **Client**: Manages customer information, including ID, name, and email.
- **Location**: Contains information about the geographical locations of pizzeria branches.
- **Pizzeria**: Holds specific pizzeria details, such as location and seating capacity.
- **Employee**: Tracks details of pizzeria employees, divided into categories like chefs and service staff.
- **Order**: Stores customer orders, linking them to clients and specific pizzerias.
- **Review**: Allows customers to submit feedback on their experiences.
- **Promotion**: Manages promotions and discounts on menu items.

### Code Details

- **ER Diagram**: Diagrams for visualizing the entities and their relationships within the database.
- **SQL Schema**: Detailed SQL schema to define tables, constraints, and relationships.
- **Data Insertion Scripts**: SQL scripts to insert sample data for testing and demonstration purposes.
- **Procedures and Functions**:
  - Procedure to display all pizzas ordered by each customer within a specified date range.
  - Function to retrieve the most popular pizza for each pizzeria along with the latest order date.
  - Exception handling function to address cases where a pizzeria has no recent reviews or orders.
- **Constraints and Rules**: Enforces business rules such as location-based employee assignments, customer order requirements, and promotion applications.

---

This README offers an overview of the project, detailing its business model and core functionalities, enabling developers and analysts to understand and work with the database effectively.
