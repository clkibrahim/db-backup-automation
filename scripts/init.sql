CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(120) NOT NULL,
    category VARCHAR(80),
    published_year INT,
    stock INT NOT NULL CHECK (stock >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    member_id INT NOT NULL REFERENCES members(member_id) ON DELETE CASCADE,
    book_id INT NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
    loan_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) NOT NULL CHECK (status IN ('borrowed', 'returned', 'late'))
);

INSERT INTO members (full_name, email, phone) VALUES
('Ibrahim Yilmaz', 'ibrahim@example.com', '05550000001'),
('Ayse Demir', 'ayse@example.com', '05550000002'),
('Mehmet Kaya', 'mehmet@example.com', '05550000003'),
('Zeynep Arslan', 'zeynep@example.com', '05550000004'),
('Ali Can', 'ali@example.com', '05550000005');

INSERT INTO books (title, author, category, published_year, stock) VALUES
('Suc ve Ceza', 'Fyodor Dostoyevski', 'Roman', 1866, 4),
('1984', 'George Orwell', 'Distopya', 1949, 6),
('Tutunamayanlar', 'Oguz Atay', 'Roman', 1971, 3),
('Simyaci', 'Paulo Coelho', 'Roman', 1988, 5),
('Kurk Mantolu Madonna', 'Sabahattin Ali', 'Roman', 1943, 2),
('Hayvan Ciftligi', 'George Orwell', 'Siyasi Fabl', 1945, 7),
('Sefiller', 'Victor Hugo', 'Klasik', 1862, 4),
('Beyaz Dis', 'Jack London', 'Macera', 1906, 3);

INSERT INTO loans (member_id, book_id, loan_date, return_date, status) VALUES
(1, 2, '2026-04-01', NULL, 'borrowed'),
(2, 1, '2026-03-28', '2026-04-05', 'returned'),
(3, 4, '2026-04-03', NULL, 'borrowed'),
(4, 6, '2026-03-20', NULL, 'late'),
(5, 3, '2026-04-02', NULL, 'borrowed');
