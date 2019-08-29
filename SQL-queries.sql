
CREATE Procedure `base-bookstore`.book_count (IN bookname VARCHAR(255))  
  BEGIN
  select  sum(receipt_amount) from `base-bookstore`.book join `base-bookstore`.receipts
   on `base-bookstore`.book.id_book=`base-bookstore`.receipts.id_book
  where `base-bookstore`.book.Book_name=bookname;
 END

CREATE Procedure `base-bookstore`.user_order (IN usr VARCHAR(255))  
  BEGIN
 Select orders.ID_Order "Order Number", Book_Name "Bookname", Order_Date "Order Date",Author_Name "Author",Publication_Year "Publication Year",Publisher_name "Publisher",Genre_Name "Genre"
  From orders join shopping_cart using(ID_Order) join registry using(ID_User) join receipts using(ID_Receipt) join book using(ID_Book) join authors using(ID_Author)
  join genres using(ID_Genre) join publishers using(ID_Publisher)
  where registry.login=usr;
 END

CREATE Procedure `base-bookstore`.authorp (IN aut VARCHAR(255))  
  BEGIN
 select book_name from book join authors using(id_author) where author_name=aut;
 END


CREATE Procedure `base-bookstore`.publishp (IN pub VARCHAR(255))  
  BEGIN
 select book_name from book join publishers using(id_publisher) where publisher_name=pub;
 END


  CREATE Procedure `base-bookstore`.genrep (IN gen VARCHAR(255))  
  BEGIN
select book_name from book join genres using(id_genre) where genre_name=gen;
 END


CREATE Procedure `base-bookstore`.InsOrd (IN log VARCHAR(255))  
  BEGIN
INSERT into `base-bookstore`.orders (Order_date,Status,Id_user)
(select CURDATE(), 'Order Formed', Id_user from registry where login=log);
 END


CREATE Procedure `base-bookstore`.InsShop (IN quan VARCHAR(255),IN bok VARCHAR(255))  
  BEGIN
INSERT into `base-bookstore`.shopping_cart (ID_Order,ID_Receipt,Amount)
 (select idord, idrecipe, quan
 from (select ID_Receipt idrecipe from book join receipts USING(ID_Book) where book_name=bok Limit 1) as tab1,
 (select max(id_order) idord from orders) as tab2); 
 END


CREATE Procedure `base-bookstore`.DelOrd (IN ord VARCHAR(255))  
  BEGIN
Delete from orders where id_order=ord;
 END
