# README
---
## 1. Το Σενάριο

Η παρούσα εργαστηριακή εφαρμογή αναπτύχθηκε στα πλαίσια της ψηφιακής βιομηχανίας και της φιλοσοφίας Industry 4.0, με στόχο την προσομοίωση ενός συστήματος διαχείρισης παραγωγικών παραγγελιών σε ένα μικροβιομηχανικό περιβάλλον.

Το σύστημα λειτουργεί ως διαδικτυακή πλατφόρμα διαχείρισης και παρακολούθησης βιομηχανικών εξαρτημάτων και γραμμών παραγωγής. Οι χρήστες μπορούν:

- Να εισάγουν νέες παραγγελίες παραγωγής
- Να παρακολουθούν την κατάσταση παραγωγής σε πραγματικό χρόνο
- Να αλλάζουν την κατάσταση μιας παραγγελίας
- Να διαγράφουν ακυρωμένες εγγραφές
- Να εξάγουν δεδομένα σε μορφή CSV για αναλύσεις

Το έργο χωρίζεται σε δύο κύρια μέρη:

### Μέρος Α — Ανάπτυξη Web Εφαρμογής

Ανάπτυξη μιας δυναμικής web εφαρμογής 3 σελίδων με:

- HTML5
- CSS3
- Vanilla JavaScript
- PHP REST API
- MariaDB / MySQL

### Μέρος Β — Σχεδίαση και Υλοποίηση Δικτύου

Υλοποίηση δικτυακής τοπολογίας υψηλής διαθεσιμότητας σε Cisco Packet Tracer με:

- 5 Cisco Routers
- OSPF Dynamic Routing
- Ring Topology
- Διασύνδεση απομακρυσμένων υποδικτύων

---

# 2. Η Αρχιτεκτονική της Εφαρμογής

Η εφαρμογή ακολουθεί μοντέλο πολυεπίπεδης αρχιτεκτονικής (multi-layer architecture).

## Επίπεδα Συστήματος

### Frontend Layer

Το frontend αποτελείται από:

- HTML5
- CSS3
- Vanilla JavaScript (ES6)
- Fetch API για asynchronous requests

Οι βασικές σελίδες είναι:

| Αρχείο        | Περιγραφή                                     |
| ------------- | --------------------------------------------- |
| `index.html`  | Dashboard παρακολούθησης παραγωγής            |
| `manage.html` | Φόρμα εισαγωγής νέων παραγγελιών              |
| `import.html` | Placeholder για μελλοντική εισαγωγή δεδομένων |

---

### Backend Layer

Το backend υλοποιείται μέσω ενός μονολιθικού RESTful controller:

```text
api.php
```

Το API διαχειρίζεται:

- GET requests
- POST requests
- PUT requests
- DELETE requests
- CSV Export functionality

Η επικοινωνία γίνεται μέσω HTTP και JSON responses.

---

### Database Layer

Η βάση δεδομένων είναι MariaDB / MySQL και αποθηκεύει:

- Παραγγελίες
- Περιγραφές εξαρτημάτων
- Καταστάσεις παραγωγής
- Χρονικές σφραγίδες

---

## Δομή Φακέλων Εφαρμογής

```text
C:\xampp\htdocs\micro-orders\
│
├── api.php
├── index.html
├── manage.html
├── import.html
└── README.md
```

---

# 3. Η Δομή της Βάσης Δεδομένων

Η εφαρμογή χρησιμοποιεί τη βάση δεδομένων:

```sql
micro_components
```

και τον βασικό πίνακα:

```sql
orders
```

## SQL Schema

```sql
CREATE DATABASE IF NOT EXISTS micro_components;
USE micro_components;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    part_number VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    status ENUM('Pending', 'In Production', 'Shipped') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## Ανάλυση Πεδίων

| Πεδίο         | Τύπος        | Περιγραφή               |
| ------------- | ------------ | ----------------------- |
| `order_id`    | INT          | Μοναδικό ID παραγγελίας |
| `part_number` | VARCHAR(100) | Κωδικός εξαρτήματος     |
| `description` | VARCHAR(255) | Περιγραφή εξαρτήματος   |
| `quantity`    | INT          | Ποσότητα παραγωγής      |
| `status`      | ENUM         | Κατάσταση παραγωγής     |
| `created_at`  | TIMESTAMP    | Ημερομηνία δημιουργίας  |

---

## Παραδείγματα Δεδομένων

```sql
INSERT INTO orders (part_number, description, quantity, status) VALUES
('MC-GEAR-05M', '0.5 Modulus Brass Spur Pinion Gear', 2500, 'In Production'),
('SNS-TE-SMD04', 'Digital Ambient Temperature Sensor Module', 450, 'Pending');
```

---

# 4. Η Διαδικασία Ανάπτυξης της Εφαρμογής (Βήματα Υλοποίησης)

## Βήμα 1 — Εγκατάσταση Περιβάλλοντος

Εγκαταστάθηκε το XAMPP περιβάλλον ώστε να παρέχονται:

- Apache Web Server
- MariaDB Database Server
- phpMyAdmin

---

## Βήμα 2 — Δημιουργία Βάσης Δεδομένων

Μέσω phpMyAdmin:

1. Δημιουργήθηκε η βάση `micro_components`
2. Δημιουργήθηκε ο πίνακας `orders`
3. Εισήχθησαν δοκιμαστικά δεδομένα

---

## Βήμα 3 — Ανάπτυξη Backend API

Υλοποιήθηκε το `api.php` με χρήση:

- PHP
- REST architecture
- SQL queries
- JSON serialization

### REST Λειτουργίες

| HTTP Method | Λειτουργία                |
| ----------- | ------------------------- |
| GET         | Ανάκτηση παραγγελιών      |
| POST        | Εισαγωγή νέας παραγγελίας |
| PUT         | Ενημέρωση κατάστασης      |
| DELETE      | Διαγραφή παραγγελίας      |

---

## Βήμα 4 — Ανάπτυξη Frontend

Κατασκευάστηκαν:

- Dashboard παρακολούθησης
- Dynamic tables
- Real-time updates
- CSV export λειτουργίες

Η επικοινωνία frontend-backend γίνεται με:

```javascript
fetch();
```

---

## Βήμα 5 — Υλοποίηση Δικτύου

Στο Cisco Packet Tracer:

- Προστέθηκαν 5 routers
- Δημιουργήθηκε ring topology
- Ρυθμίστηκε OSPF routing
- Διασυνδέθηκαν δύο LAN υποδίκτυα

---

## Βήμα 6 — Έλεγχοι και Δοκιμές

Πραγματοποιήθηκαν:

- Ping tests
- Traceroute tests
- HTTP access tests
- CRUD operation tests

---

# 5. Η Δικτυακή Αρχιτεκτονική

Η δικτυακή υποδομή σχεδιάστηκε ως fault-tolerant ring topology.

## Δομή Τοπολογίας

Η αρχιτεκτονική περιλαμβάνει:

- 5 Cisco 2911 Routers
- 2 Cisco 2960 Switches
- 2 Host Devices
- OSPF Area 0 Dynamic Routing

---

## Τοπολογία Δικτύου

```text
RouterLeft ---- Router0 ---- Router4
     |                            |
     |                            |
   Router2 ---------------- Router3
```

---

## Υποδίκτυα

| Υποδίκτυο       | Περιγραφή             |
| --------------- | --------------------- |
| 192.168.10.0/24 | Production LAN        |
| 192.168.20.0/24 | Remote Management LAN |
| 10.0.1.0/30     | WAN Link              |
| 10.0.2.0/30     | WAN Link              |
| 10.0.3.0/30     | WAN Link              |
| 10.0.4.0/30     | WAN Link              |
| 10.0.5.0/30     | WAN Link              |

---

## Dynamic Routing

Χρησιμοποιήθηκε:

```text
OSPF Area 0
```

ώστε:

- Να υπάρχει αυτόματη δρομολόγηση
- Να αποφεύγονται single points of failure
- Να υπάρχει redundancy
- Να γίνεται αυτόματη εύρεση εναλλακτικών διαδρομών

---

## Έλεγχος Συνδεσιμότητας

Πραγματοποιήθηκαν:

- `ping 192.168.10.10`
- `tracert 192.168.10.10`
- HTTP browser access μέσω:

```text
http://192.168.10.10
```

---

# 6. Η Χρήση Εργαλείων AI

Σύμφωνα με τις ακαδημαϊκές οδηγίες, χρησιμοποιήθηκαν εργαλεία Τεχνητής Νοημοσύνης για υποστήριξη της ανάπτυξης και της τεχνικής τεκμηρίωσης.

## Χρήσεις AI στο Έργο

### 1. Δημιουργία Backend Structure

Χρησιμοποιήθηκε Generative AI για:

- REST API routing
- HTTP method handling
- SQL transaction structure

---

### 2. Σχεδίαση UI / UX

Η AI συνέβαλε:

- Στη δημιουργία dark industrial theme
- Στη δομή CSS layouts
- Στη σχεδίαση status badges και tables

---

### 3. Δημιουργία Δοκιμαστικών Δεδομένων

Η AI χρησιμοποιήθηκε για:

- Δημιουργία synthetic datasets
- Παραγωγή βιομηχανικών component names
- Δημιουργία testing scenarios

---

### 4. Δημιουργία Cisco IOS Commands

Η AI βοήθησε:

- Στη μετατροπή topology diagrams σε IOS commands
- Στην ταχύτερη ρύθμιση OSPF routing
- Στη διαμόρφωση interfaces

---

## Δήλωση Συμμόρφωσης

Όλα τα AI-generated αποτελέσματα:

- Ελέγχθηκαν χειροκίνητα
- Προσαρμόστηκαν στις απαιτήσεις του έργου
- Δοκιμάστηκαν λειτουργικά
- Ενσωματώθηκαν από την ομάδα ανάπτυξης

---

# Συμπέρασμα

Το έργο υλοποιεί ένα πλήρες βιομηχανικό πληροφοριακό σύστημα που συνδυάζει:

- Web εφαρμογές
- REST APIs
- Βάσεις δεδομένων
- Δικτυακές υποδομές
- Dynamic routing
- Τεχνολογίες Industry 4.0

Η εφαρμογή αποδεικνύει την ενοποίηση software και network infrastructure σε ένα ολοκληρωμένο ψηφιακό βιομηχανικό περιβάλλον.
