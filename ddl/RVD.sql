/ * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  
 * * 	 	 	 	 	 	 	 T A B L E S  
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
 u s e   r v d r e h e a r s a l  
 g o  
  
 i f   o b j e c t _ i d ( ' d b o . A p p _ A t t r i b u t e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . A p p _ A t t r i b u t e  
 g o      
 c r e a t e   t a b l e   d b o . A p p _ A t t r i b u t e (  
 	 A p p _ A t t r i b u t e _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 ) 	 n o t   n u l l   c o n s t r a i n t   a p p _ a t t r i b u t e _ p k   p r i m a r y   k e y ,  
 	 A t t r i b u t e _ I D   	 	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l ,  
 	 A t t r i b u t e _ N a m e 	 	 	 n v a r c h a r ( 2 5 5 ) 	 	 	 n o t   n u l l ,  
 	 A c t i v e _ F l a g   	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ a t t r i b u t e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ a t t r i b u t e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ a t t r i b u t e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . A p p _ D a t a _ V a l i d a t i o n ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . A p p _ D a t a _ V a l i d a t i o n  
 g o      
 c r e a t e   t a b l e   d b o . A p p _ D a t a _ V a l i d a t i o n (  
 	 A p p _ D a t a _ V a l i d a t i o n _ K e y   i n t e g e r   i d e n t i t y ( 1 , 1 ) 	 n o t   n u l l   c o n s t r a i n t   a p p _ d a t a _ v a l i d a t i o n _ p k   p r i m a r y   k e y ,  
 	 T a b l e _ N a m e 	   	 	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l ,  
 	 T e s t _ N a m e 	 	 	 	 n v a r c h a r ( 2 5 5 ) 	 	 	 n o t   n u l l ,  
 	 S t a t u s _ C o d e 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l ,  
 	 A c t i v e _ F l a g   	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ d a t a _ v a l i d a t i o n _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ d a t a _ v a l i d a t i o n _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ d a t a _ v a l i d a t i o n _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . A p p _ M e t a d a t a ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . A p p _ M e t a d a t a  
 g o      
 c r e a t e   t a b l e   d b o . A p p _ M e t a d a t a (  
 	 A p p _ M e t a d a t a _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 ) 	 n o t   n u l l   c o n s t r a i n t   a p p _ m e t a d a t a _ p k   p r i m a r y   k e y ,  
 	 A p p _ M e t a d a t a _ T y p e _ C o d e   	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l ,  
 	 A t t r i b u t e _ N a m e   	 	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l ,  
 	 A t t r i b u t e _ V a l u e   	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l ,  
 	 A c t i v e _ F l a g   	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ m e t a d a t a _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ m e t a d a t a _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ m e t a d a t a _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . A p p _ S t a t u s ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . A p p _ S t a t u s  
 g o      
 c r e a t e   t a b l e   d b o . A p p _ S t a t u s (  
 	 A p p _ S t a t u s _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   a p p _ s t a t u s _ p k   p r i m a r y   k e y ,  
 	 A p p _ S t a t u s _ C o d e   	 	 n v a r c h a r ( 1 0 ) 	 	 	 n o t   n u l l ,  
 	 A p p _ S t a t u s   	 	 	 	 n v a r c h a r ( 1 5 0 ) 	 	 	 n o t   n u l l ,  
 	 A c t i v e _ F l a g   	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ s t a t u s _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ s t a t u s _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ s t a t u s _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . A p p _ T y p e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . A p p _ T y p e  
 g o      
 c r e a t e   t a b l e   d b o . A p p _ T y p e (  
 	 A p p _ T y p e _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   a p p _ t y p e _ p k   p r i m a r y   k e y ,  
 	 A p p _ T y p e _ C o d e   	 	 	 n v a r c h a r ( 3 0 )   	 	 	 n o t   n u l l ,  
 	 A p p _ T y p e _ N a m e   	 	 	 n v a r c h a r ( 1 0 0 )   	 	 	 n o t   n u l l ,  
 	 H U B _ A p p _ T y p e _ I D 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   a p p _ t y p e _ a k   u n i q u e , 	  
 	 A c t i v e _ F l a g   	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ t y p e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ t y p e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ t y p e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o    
  
  
 i f   o b j e c t _ i d ( ' d b o . A p p _ V e r s i o n ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . A p p _ V e r s i o n  
 g o    
 c r e a t e   t a b l e   d b o . A p p _ V e r s i o n (  
 	 A p p _ V e r s i o n _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   a p p _ v e r s i o n _ p k   p r i m a r y   k e y ,  
 	 A p p _ V e r s i o n _ N u m b e r   	 	 d e c i m a l ( 5 , 2 ) 	 	 	 n o t   n u l l   c o n s t r a i n t   a p p _ v e r s i o n _ a k   u n i q u e ,  
 	 A p p _ V e r s i o n _ N a m e   	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l ,  
 	 N o t e s   	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 A c t i v e _ F l a g   	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ v e r s i o n _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ v e r s i o n _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a p p _ v e r s i o n _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . A t t r i b u t e _ D a t a _ T y p e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . A t t r i b u t e _ D a t a _ T y p e  
 g o    
 c r e a t e   t a b l e   d b o . A t t r i b u t e _ D a t a _ T y p e (  
 	 A t t r i b u t e _ D a t a _ T y p e _ K e y   	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   a t t r i b u t e _ d a t a _ t y p e _ p k   p r i m a r y   k e y ,  
 	 A t t r i b u t e _ D a t a _ T y p e   	 	 n v a r c h a r ( 3 0 )   	 	 	 n o t   n u l l   c o n s t r a i n t   a t t r i b u t e _ d a t a _ t y p e _ a k   u n i q u e ,  
 	 D a t a _ F o r m a t   	 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 A t t r i b u t e _ D a t a _ T y p e _ D e s c   	 n v a r c h a r ( 2 5 5 ) ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a t t r i b u t e _ d a t a _ t y p e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a t t r i b u t e _ d a t a _ t y p e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a t t r i b u t e _ d a t a _ t y p e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . A t t r i b u t e _ L O V ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . A t t r i b u t e _ L O V  
 g o    
 c r e a t e   t a b l e   d b o . A t t r i b u t e _ L O V (  
 	 A t t r i b u t e _ L O V _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   a t t r i b u t e _ l o v _ p k   p r i m a r y   k e y ,  
 	 A t t r i b u t e _ L O V   	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l   c o n s t r a i n t   a t t r i b u t e _ l o v _ a k   u n i q u e ,  
 	 A t t r i b u t e _ L O V _ V a l u e   	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a t t r i b u t e _ l o v _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a t t r i b u t e _ l o v _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ a t t r i b u t e _ l o v _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . B A _ E v e n t _ V o l u n t e e r _ I n v i t e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . B A _ E v e n t _ V o l u n t e e r _ I n v i t e  
 g o    
 c r e a t e   t a b l e   d b o . B A _ E v e n t _ V o l u n t e e r _ I n v i t e (  
 	 B A _ E v e n t _ V o l u n t e e r _ I n v i t e _ K e y 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   b a _ e v e n t _ v o l u n t e e r _ a t t e n d a n c e _ p k   p r i m a r y   k e y ,  
 	 E v e n t _ I D   	 	 	 	 	 	 b i g i n t 	 	 	 	 	 n o t   n u l l ,  
 	 V o l u n t e e r _ I D 	 	 	 	 	 b i g i n t 	 	 	 	 	 n o t   n u l l ,  
 	 P e r s o n _ G U I D 	 	 	 	 	 	 u n i q u e i d e n t i f i e r 	 	 n o t   n u l l ,  
 	 E v e n t _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) 	 	 	 n o t   n u l l ,  
 	 L i n k 	 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 S t a r t _ D a t e 	 	 	 	 	 	 d a t e t i m e ,  
 	 E v e n t _ L e n g t h   	 	 	 	 	 i n t e g e r ,  
 	 M a x i m u m _ C o n f i r m a t i o n s   	 	 	 i n t e g e r ,  
 	 S t a t u s _ D a y _ 1   	 	 	 	 	 n v a r c h a r ( 5 0 ) ,    
 	 S t a t u s _ D a y _ 2   	 	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 S t a t u s _ D a y _ 3   	 	 	 	 	 n v a r c h a r ( 5 0 ) ,    
 	 S t a t u s _ D a y _ 4   	 	 	 	 	 n v a r c h a r ( 5 0 ) ,    
 	 S t a t u s _ D a y _ 5   	 	 	 	 	 n v a r c h a r ( 5 0 ) ,    
 	 S t a t u s _ D a y _ 6   	 	 	 	 	 n v a r c h a r ( 5 0 ) ,    
 	 S t a t u s _ D a y _ 7   	 	 	 	 	 n v a r c h a r ( 5 0 ) ,    
 	 C o m m e n t s   	 	 	 	 	 	 n v a r c h a r ( m a x ) ,  
 	 M a n a g e r _ C o m m e n t s   	 	 	 	 n v a r c h a r ( m a x ) , 	  
 	 A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ e v e n t _ v o l u n t e e r _ i n v i t e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ e v e n t _ v o l u n t e e r _ i n v i t e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ e v e n t _ v o l u n t e e r _ i n v i t e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   b a _ e v e n t _ v o l u n t e e r _ i n v i t e _ a k   u n i q u e   (   e v e n t _ i d ,   v o l u n t e e r _ i d   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . b a _ e v e n t _ v o l u n t e e r _ i n v i t e   a d d   c o n s t r a i n t   b a _ e v e n t _ v o l u n t e e r _ i n v i t e _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ i d   )   r e f e r e n c e s   d b o . v o l u n t e e r (   b a _ v o l u n t e e r _ i d   )  
 g o  
  
 i f   o b j e c t _ i d ( ' d b o . B A _ P r o j e c t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . B A _ P r o j e c t  
 g o    
 c r e a t e   t a b l e   d b o . B A _ P r o j e c t (  
 	 B A _ P r o j e c t _ K e y 	   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   b a _ p r o j e c t _ p k   p r i m a r y   k e y ,  
 	 P r o j e c t _ I D   	 	 	 	 	 b i g i n t   	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   b a _ p r o j e c t _ a k   u n i q u e ,  
 	 P r o j e c t _ N u m b e r   	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 P r o j e c t _ D e s c   	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 P r o j e c t _ T y p e   	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 P r o j e c t _ S t a t u s   	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . B A _ P r o j e c t _ G r o u p ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . B A _ P r o j e c t _ G r o u p  
 g o    
 c r e a t e   t a b l e   d b o . B A _ P r o j e c t _ G r o u p (  
 	 B A _ P r o j e c t _ G r o u p _ K e y 	   	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   b a _ p r o j e c t _ g r o u p _ p k   p r i m a r y   k e y ,  
 	 P r o j e c t _ I D   	 	 	 	 	 b i g i n t   	 	 	 	 	 n o t   n u l l ,  
 	 P r o j e c t _ N u m b e r   	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 P r o j e c t _ N a m e   	 	 	 	 n v a r c h a r ( 2 0 0 ) , 	  
 	 G r o u p _ I D 	 	 	 	 	 b i g i n t 	 	 	 	 	 n o t   n u l l ,  
 	 G r o u p _ N a m e   	 	 	 	 	 n v a r c h a r ( 2 0 0 ) , 	  
 	 Z o n e 	 	 	 	 	 	 i n t e g e r ,  
 	 P r i v a t e _ F l a g 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ g r o u p _ p r i v a t e _ f l a g   d e f a u l t   ' Y ' ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ g r o u p _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ g r o u p _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ g r o u p _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   b a _ p r o j e c t _ g r o u p _ a k   u n i q u e   (   p r o j e c t _ i d ,   g r o u p _ i d   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . b a _ p r o j e c t _ g r o u p   a d d   c o n s t r a i n t   b a _ p r o j e c t _ g r o u p _ f k _ b a _ p r o j e c t   f o r e i g n   k e y   (   p r o j e c t _ i d   )   r e f e r e n c e s   d b o . b a _ p r o j e c t (   p r o j e c t _ i d   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . B A _ P r o j e c t _ G r o u p _ V o l u n t e e r ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . B A _ P r o j e c t _ G r o u p _ V o l u n t e e r  
 g o    
 c r e a t e   t a b l e   d b o . B A _ P r o j e c t _ G r o u p _ V o l u n t e e r (  
 	 B A _ P r o j e c t _ G r o u p _ V o l u n t e e r _ K e y 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   b a _ p r o j e c t _ g r o u p _ v o l u n t e e r _ p k   p r i m a r y   k e y ,  
 	 B A _ P r o j e c t _ G r o u p _ K e y 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 V o l u n t e e r _ K e y 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 P r o j e c t _ I D   	 	 	 	 	 	 b i g i n t   	 	 	 	 	 n o t   n u l l ,  
 	 G r o u p _ I D 	 	 	 	 	 	 b i g i n t 	 	 	 	 	 n o t   n u l l ,  
 	 P e r s o n _ G U I D 	 	 	 	 	 	 u n i q u e i d e n t i f i e r 	 	 n o t   n u l l , 	  
 	 A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ g r o u p _ v o l u n t e e r _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ g r o u p _ v o l u n t e e r _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ g r o u p _ v o l u n t e e r _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   b a _ p r o j e c t _ g r o u p _ v o l u n t e e r _ a k   u n i q u e   (   p r o j e c t _ i d ,   g r o u p _ i d ,   p e r s o n _ g u i d   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . b a _ p r o j e c t _ g r o u p _ v o l u n t e e r   a d d   c o n s t r a i n t   b a _ p r o j e c t _ g r o u p _ v o l u n t e e r _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
 a l t e r   t a b l e   d b o . b a _ p r o j e c t _ g r o u p _ v o l u n t e e r   a d d   c o n s t r a i n t   b a _ p r o j e c t _ g r o u p _ v o l u n t e e r _ f k _ b a _ p r o j e c t   f o r e i g n   k e y   (   p r o j e c t _ i d   )   r e f e r e n c e s   d b o . b a _ p r o j e c t (   p r o j e c t _ i d   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . B A _ P r o j e c t _ V o l u n t e e r ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . B A _ P r o j e c t _ V o l u n t e e r  
 g o    
 c r e a t e   t a b l e   d b o . B A _ P r o j e c t _ V o l u n t e e r (  
 	 B A _ P r o j e c t _ V o l u n t e e r _ K e y 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   b a _ p r o j e c t _ v o l u n t e e r _ p k   p r i m a r y   k e y ,  
 	 P r o j e c t _ I D   	 	 	 	 	 b i g i n t   	 	 	 	 	 n o t   n u l l ,  
 	 V o l u n t e e r _ I D 	 	 	 	 b i g i n t 	 	 	 	 	 n o t   n u l l ,  
 	 P e r s o n _ G U I D 	 	 	 	 	 u n i q u e i d e n t i f i e r 	 	 n o t   n u l l ,  
 	 I n v i t e d _ F l a g 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l ,  
 	 A c c e p t e d _ F l a g 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l ,  
 	 A t t e n d e d _ F l a g 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ v o l u n t e e r _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ v o l u n t e e r _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ v o l u n t e e r _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   b a _ p r o j e c t _ v o l u n t e e r _ a k   u n i q u e   (   p r o j e c t _ i d ,   v o l u n t e e r _ i d   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . b a _ p r o j e c t _ v o l u n t e e r   a d d   c o n s t r a i n t   b a _ p r o j e c t _ v o l u n t e e r _ f k _ b a _ p r o j e c t   f o r e i g n   k e y   (   p r o j e c t _ i d   )   r e f e r e n c e s   d b o . b a _ p r o j e c t (   p r o j e c t _ i d   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . B A _ P r o j e c t _ V o l u n t e e r _ A t t e n d a n c e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . B A _ P r o j e c t _ V o l u n t e e r _ A t t e n d a n c e  
 g o    
 c r e a t e   t a b l e   d b o . B A _ P r o j e c t _ V o l u n t e e r _ A t t e n d a n c e (  
 	 B A _ P r o j e c t _ V o l u n t e e r _ A t t e n d a n c e _ K e y 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   b a _ p r o j e c t _ v o l u n t e e r _ a t t e n d a n c e _ p k   p r i m a r y   k e y ,  
 	 P r o j e c t _ I D   	 	 	 	 	 	 	 b i g i n t   	 	 	 	 	 n o t   n u l l ,  
 	 V o l u n t e e r _ I D 	 	 	 	 	 	 b i g i n t 	 	 	 	 	 n o t   n u l l ,  
 	 P e r s o n _ G U I D 	 	 	 	 	 	 	 u n i q u e i d e n t i f i e r 	 	 n o t   n u l l ,  
 	 C h e c k _ I n _ D a t e   	 	 	 	 	 	 d a t e t i m e ,  
 	 E v e n t _ I D   	 	 	 	 	 	 	 b i g i n t ,  
 	 E v e n t _ N a m e   	 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 S t a t u s   	 	 	 	 	 	 	 	 n v a r c h a r ( 5 0 ) ,   	  
 	 A c t i v e _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ v o l u n t e e r _ a t t e n d a n c e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ v o l u n t e e r _ a t t e n d a n c e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ b a _ p r o j e c t _ v o l u n t e e r _ a t t e n d a n c e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   b a _ p r o j e c t _ v o l u n t e e r _ a t t e n d a n c e _ a k   u n i q u e   (   p r o j e c t _ i d ,   v o l u n t e e r _ i d ,   e v e n t _ i d ,   c h e c k _ i n _ d a t e   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . b a _ p r o j e c t _ v o l u n t e e r _ a t t e n d a n c e   a d d   c o n s t r a i n t   b a _ p r o j e c t _ v o l u n t e e r _ a t t e n d a n c e _ f k _ b a _ p r o j e c t   f o r e i g n   k e y   (   p r o j e c t _ i d   )   r e f e r e n c e s   d b o . b a _ p r o j e c t (   p r o j e c t _ i d   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . C a l _ D i m ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . C a l _ D i m  
 g o    
 c r e a t e   t a b l e   d b o . C a l _ D i m (  
 	 c a l _ d t   	 	 	 	 d a t e   	 	 	 n o t   n u l l   c o n s t r a i n t   c a l _ d i m _ p k   p r i m a r y   k e y ,  
 	 d a y _ n m   	 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 d a y _ o f _ w k   	 	 	 i n t ,  
 	 d a y _ o f _ m t h   	 	 	 i n t ,  
 	 d a y _ n m _ s u f f i x   	 	 c h a r ( 2 ) ,  
 	 d a y _ o f _ w k _ i n _ m t h   	 t i n y i n t ,  
 	 d a y _ i n _ y r   	 	 	 i n t ,  
 	 w k n d _ i n d   	 	 	 i n t   	 	 	 n o t   n u l l ,  
 	 w k   	 	 	 	 	 i n t ,  
 	 w k _ s t a r t _ d t   	 	 d a t e ,  
 	 w k _ e n d _ d t   	 	 	 d a t e ,  
 	 w k _ i n _ m t h   	 	 	 t i n y i n t ,  
 	 m t h   	 	 	 	 i n t ,  
 	 m t h _ n m   	 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 m t h _ s t a r t _ d t   	 	 d a t e ,  
 	 m t h _ e n d _ d t   	 	 	 d a t e ,  
 	 n e x t _ m t h _ s t a r t _ d t   	 d a t e ,  
 	 n e x t _ m t h _ e n d _ d t   	 d a t e ,  
 	 q t r   	 	 	 	 i n t ,  
 	 q t r _ s t a r t _ d t   	 	 d a t e ,  
 	 q t r _ e n d _ d t   	 	 	 d a t e ,  
 	 y r   	 	 	 	 	 i n t ,  
 	 y r _ s t a r t _ d t   	 	 d a t e ,  
 	 y r _ e n d _ d t   	 	 	 d a t e ,  
 	 l e a p _ y r _ i n d   	 	 b i t ,  
 	 y r _ 5 3 _ w k _ i n d   	 	 i n t   n o t   n u l l   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . C o n g ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . C o n g  
 g o    
 c r e a t e   t a b l e   d b o . C o n g (  
 	 C o n g _ K e y   	 	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   c o n g _ p k   p r i m a r y   k e y ,  
 	 C o n g _ N u m b e r   	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l   c o n s t r a i n t   c o n g _ a k   u n i q u e ,  
 	 C o n g   	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 C o n g _ F u l l n a m e   	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 C i t y   	 	 	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 S t a t e _ K e y   	 	 	 	 	 i n t e g e r ,  
 	 P o s t a l _ C o d e _ K e y 	 	 	 	 i n t e g e r ,  
 	 C o u n t r y _ K e y 	 	 	 	 	 i n t e g e r ,  
 	 C i r c u i t   	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 L a n g u a g e _ C o d e   	 	 	 	 n v a r c h a r ( 1 0 ) ,  
 	 K H _ A d d r e s s 1   	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 K H _ A d d r e s s 2   	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 K H _ C i t y   	 	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 K H _ S t a t e _ C o d e   	 	 	 	 n v a r c h a r ( 1 0 ) ,  
 	 K H _ P o s t a l _ C o d e 	 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 K H _ C o u n t r y _ C o d e 	 	 	 	 n v a r c h a r ( 1 0 ) ,  
 	 C O B E _ V o l u n t e e r _ K e y 	 	 	 i n t e g e r ,  
 	 C O B E _ P e r s o n _ I D 	 	 	 	 i n t e g e r ,  
 	 C O B E _ F i r s t _ N a m e   	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 C O B E _ L a s t _ N a m e   	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 C O B E _ E m a i l   	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 C O B E _ M o b i l e _ P h o n e 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 S e c _ V o l u n t e e r _ K e y 	 	 	 i n t e g e r ,  
 	 S e c _ P e r s o n _ I D 	 	 	 	 i n t e g e r ,  
 	 S e c _ F i r s t _ N a m e   	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 S e c _ L a s t _ N a m e   	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 S e c _ E m a i l   	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 S e c _ M o b i l e _ P h o n e 	 	 	 n v a r c h a r ( 1 0 0 ) , 	  
 	 C O _ V o l u n t e e r _ K e y 	 	 	 i n t e g e r ,  
 	 C O _ P e r s o n _ I D 	 	 	 	 i n t e g e r ,  
 	 C O _ F i r s t _ N a m e   	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 C O _ L a s t _ N a m e   	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 C O _ E m a i l   	 	 	 	 	 n v a r c h a r ( 1 5 0 ) , 	  
 	 C O _ M o b i l e _ P h o n e 	 	 	 	 n v a r c h a r ( 1 0 0 ) , 	  
 	 D r i v i n g _ D i s t a n c e _ F l a g   	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ c o n g _ d r i v i n g _ d i s t a n c e _ f l a g   d e f a u l t   ' N ' ,  
 	 D i s s o l v e d _ D a t e   	 	 	 	 d a t e ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ c o n g _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ c o n g _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ c o n g _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o 	  
  
 a l t e r   t a b l e   d b o . c o n g   a d d   c o n s t r a i n t   c o n g _ f k _ p o s t a l _ c o d e   f o r e i g n   k e y   (   p o s t a l _ c o d e _ k e y   )   r e f e r e n c e s   d b o . p o s t a l _ c o d e (   p o s t a l _ c o d e _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . c o n g   a d d   c o n s t r a i n t   c o n g _ f k _ s t a t e   f o r e i g n   k e y   (   s t a t e _ k e y   )   r e f e r e n c e s   d b o . s t a t e (   s t a t e _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . c o n g   a d d   c o n s t r a i n t   c o n g _ f k _ c o u n t r y   f o r e i g n   k e y   (   c o u n t r y _ k e y   )   r e f e r e n c e s   d b o . c o u n t r y (   c o u n t r y _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . C o u n t r y ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . C o u n t r y  
 g o    
 c r e a t e   t a b l e   d b o . C o u n t r y (  
 	 C o u n t r y _ K e y   	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   c o u n t r y _ p k   p r i m a r y   k e y ,  
 	 C o u n t r y _ C o d e   	 	 	 	 n v a r c h a r ( 3 )   	 	 	 n o t   n u l l   c o n s t r a i n t   c o u n t r y _ a k   u n i q u e ,  
 	 C o u n t r y   	 	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l ,  
 	 C o u n t r y _ V I D   	 	 	 	 i n t e g e r ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ c o u n t r y _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ c o u n t r y _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ c o u n t r y _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . D e p t _ A s g n ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . D e p t _ A s g n  
 g o    
 c r e a t e   t a b l e   d b o . D e p t _ A s g n (  
 	 D e p t _ A s g n _ K e y   	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   d e p t _ a s g n _ p k   p r i m a r y   k e y ,  
 	 H P R _ D e p t _ K e y   	 	 	 	 i n t e g e r   	 	 	   	 n o t   n u l l ,  
 	 H P R _ D e p t _ S h a r e p o i n t _ K e y 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 H P R _ C r e w _ K e y 	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ c r e w   d e f a u l t   0 ,  
 	 H P R _ C r e w _ S h a r e p o i n t _ K e y 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 H P R _ D e p t _ R o l e _ K e y 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ r o l e   d e f a u l t   0 ,  
 	 H P R _ D e p t _ R o l e _ S h a r e p o i n t _ K e y   n v a r c h a r ( 2 5 5 ) ,  
 	 E n r o l l m e n t _ K e y 	 	 	 	 i n t e g e r ,  
 	 S k i l l _ L e v e l 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 D e p t _ S t a r t _ D a t e 	 	 	 	 d a t e ,  
 	 D e p t _ E n d _ D a t e 	 	 	 	 d a t e ,  
 	 N o t e s 	 	 	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 D e p t _ F i r s t _ N a m e 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 D e p t _ L a s t _ N a m e 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 D e p t _ A s g n _ S t a t u s _ K e y 	 	 i n t e g e r ,  
 	 P r i o r i t y _ K e y 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ p r i o r i t y   d e f a u l t   3 ,  
 	 C a n d i d a t e _ 1 _ N a m e 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 C a n d i d a t e _ 1 _ P r o f i l e 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 C a n d i d a t e _ 2 _ N a m e 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 C a n d i d a t e _ 2 _ P r o f i l e 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 C a n d i d a t e _ 3 _ N a m e 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 C a n d i d a t e _ 3 _ P r o f i l e 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 V T C _ M e e t i n g _ C o d e 	 	 	 n v a r c h a r ( 1 0 ) 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ v t c _ m t _ c o d e   d e f a u l t   ' N ' ,  
 	 V o l u n t e e r _ K e y 	 	 	 	 i n t e g e r ,  
 	 P S _ S t a r t _ D a t e 	 	   	 	 d a t e ,  
 	 P S _ E n d _ D a t e 	 	 	 	 	 d a t e ,  
 	 M a r i t a l _ S t a t u s _ K e y 	 	 	 i n t e g e r ,  
 	 C o n g _ S e r v a n t _ C o d e 	 	 	 n v a r c h a r ( 3 ) ,  
 	 P S _ N o t e s 	 	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 I n v i t e _ C h a r t _ C o m m e n t s 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 I D _ S P 	 	 	 	 	 	 i n t e g e r ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 T e s t _ D a t a _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ t e s t _ d a t a _ f l a g   d e f a u l t   ' N ' ,  
 	 S y n c _ D a t a _ F l a g 	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . d e p t _ a s g n   a d d   c o n s t r a i n t   d e p t _ a s g n _ f k _ d e p t _ a s g n _ s t a t u s   f o r e i g n   k e y   (   d e p t _ a s g n _ s t a t u s _ k e y   )   r e f e r e n c e s   d b o . d e p t _ a s g n _ s t a t u s (   d e p t _ a s g n _ s t a t u s _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . d e p t _ a s g n   a d d   c o n s t r a i n t   d e p t _ a s g n _ f k _ d e p t   f o r e i g n   k e y   (   h p r _ d e p t _ k e y   )   r e f e r e n c e s   d b o . h p r _ d e p t (   h p r _ d e p t _ k e y   )  
 g o  
 - - a l t e r   t a b l e   d b o . d e p t _ a s g n   w i t h   n o c h e c k   a d d   c o n s t r a i n t   d e p t _ a s g n _ f k _ c r e w   f o r e i g n   k e y   (   h p r _ c r e w _ k e y   )   r e f e r e n c e s   d b o . h p r _ c r e w (   h p r _ c r e w _ k e y   )  
 - - g o  
 a l t e r   t a b l e   d b o . d e p t _ a s g n   w i t h   n o c h e c k   a d d   c o n s t r a i n t   d e p t _ a s g n _ f k _ d e p t _ r o l e   f o r e i g n   k e y   (   h p r _ d e p t _ r o l e _ k e y   )   r e f e r e n c e s   d b o . h p r _ d e p t _ r o l e (   h p r _ d e p t _ r o l e _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . d e p t _ a s g n   a d d   c o n s t r a i n t   d e p t _ a s g n _ f k _ p r i o r i t y   f o r e i g n   k e y   (   p r i o r i t y _ k e y   )   r e f e r e n c e s   d b o . p r i o r i t y (   p r i o r i t y _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . D e p t _ A s g n _ P h a s e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . D e p t _ A s g n _ P h a s e  
 g o    
 c r e a t e   t a b l e   d b o . D e p t _ A s g n _ P h a s e (  
 	 D e p t _ A s g n _ P h a s e _ K e y 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   d e p t _ a s g n _ p h a s e _ p k   p r i m a r y   k e y ,  
 	 D e p t _ A s g n _ P h a s e _ C o d e 	 	 n v a r c h a r ( 1 0 )   	 	 	 n o t   n u l l ,  
 	 D e p t _ A s g n _ P h a s e 	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ p h a s e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ p h a s e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ p h a s e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . D e p t _ A s g n _ S t a t u s ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . D e p t _ A s g n _ S t a t u s  
 g o    
 c r e a t e   t a b l e   d b o . D e p t _ A s g n _ S t a t u s (  
 	 D e p t _ A s g n _ S t a t u s _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   d e p t _ a s g n _ s t a t u s _ p k   p r i m a r y   k e y ,  
 	 D e p t _ A s g n _ S t a t u s _ T y p e 	 	 n v a r c h a r ( 3 ) 	 	 	 	 n o t   n u l l ,   	 	 - -   P S   o r   C I   o r   V O L   ( V o l u n t e e r )  
 	 D e p t _ A s g n _ S t a t u s _ C o d e   	 	 n v a r c h a r ( 1 0 )   	 	 	 n o t   n u l l ,  
 	 D e p t _ A s g n _ S t a t u s   	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ s t a t u s _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ s t a t u s _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ s t a t u s _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . d e p t _ a s g n _ s t a t u s   a d d   c o n s t r a i n t   d e p t _ a s g n _ s t a t u s _ a k   u n i q u e   (   d e p t _ a s g n _ s t a t u s _ t y p e ,   d e p t _ a s g n _ s t a t u s _ c o d e   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . D e p t _ A s g n _ V o l u n t e e r ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . D e p t _ A s g n _ V o l u n t e e r  
 g o    
 c r e a t e   t a b l e   d b o . D e p t _ A s g n _ V o l u n t e e r (  
 	 D e p t _ A s g n _ V o l u n t e e r _ K e y   	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   d e p t _ a s g n _ v o l u n t e e r _ p k   p r i m a r y   k e y ,  
 	 D e p t _ A s g n _ K e y 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 V o l u n t e e r _ K e y 	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 D e p t _ A s g n _ P h a s e _ K e y 	 	 	 i n t e g e r   	 	 	   	 n o t   n u l l ,  
 	 D e p t _ A s g n _ S t a t u s _ K e y 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 N o t e s 	 	 	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ v o l u n t e e r _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ v o l u n t e e r _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ d e p t _ a s g n _ v o l u n t e e r _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . d e p t _ r o l e _ v o l u n t e e r   a d d   c o n s t r a i n t   d e p t _ a s g n _ v o l u n t e e r _ a k   u n i q u e   (   d e p t _ r o l e _ k e y ,   v o l u n t e e r _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . d e p t _ r o l e _ v o l u n t e e r   a d d   c o n s t r a i n t   d e p t _ a s g n _ v o l u n t e e r _ f k _ d e p t _ a s g n   f o r e i g n   k e y   (   d e p t _ a s g n _ k e y   )   r e f e r e n c e s   d b o . d e p t _ a s g n (   d e p t _ a s g n _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . d e p t _ r o l e _ v o l u n t e e r   a d d   c o n s t r a i n t   d e p t _ a s g n _ v o l u n t e e r _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . d e p t _ r o l e _ v o l u n t e e r   a d d   c o n s t r a i n t   d e p t _ a s g n _ v o l u n t e e r _ f k _ d e p t _ a s g n _ p h a s e   f o r e i g n   k e y   (   d e p t _ a s g n _ p h a s e _ k e y   )   r e f e r e n c e s   d b o . d e p t _ a s g n _ p h a s e (   d e p t _ a s g n _ p h a s e _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . d e p t _ r o l e _ v o l u n t e e r   a d d   c o n s t r a i n t   d e p t _ a s g n _ v o l u n t e e r _ f k _ d e p t _ a s g n _ s t a t u s   f o r e i g n   k e y   (   d e p t _ a s g n _ s t a t u s _ k e y   )   r e f e r e n c e s   d b o . d e p t _ a s g n _ s t a t u s (   d e p t _ a s g n _ s t a t u s _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . E n r o l l m e n t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . E n r o l l m e n t  
 g o    
 c r e a t e   t a b l e   d b o . E n r o l l m e n t (  
 	 E n r o l l m e n t _ K e y   	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   e n r o l l m e n t _ p k   p r i m a r y   k e y ,  
 	 E n r o l l m e n t _ C o d e   	 	 	 n v a r c h a r ( 3 0 )   	 	 	 n o t   n u l l ,  
 	 E n r o l l m e n t   	 	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l ,  
 	 E n r o l l m e n t _ D e s c   	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 R a n k _ N u m   	 	 	 	 	 s m a l l i n t ,  
 	 P r i m a r y _ F l a g   	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 F T S _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 S F T S _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 B e t h e l _ F l a g   	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 B e t h e l _ F a m i l y _ F l a g   	 	 	 n v a r c h a r ( 1 ) ,  
 	 R e g u l a r _ B e t h e l _ F l a g   	 	 n v a r c h a r ( 1 ) ,  
 	 F o r e i g n _ S e r v i c e _ F l a g   	 	 n v a r c h a r ( 1 ) ,  
 	 T r a n s i t i o n _ F l a g   	 	 	 n v a r c h a r ( 1 ) ,  
 	 S t a r t _ D a t e   	 	 	 	 	 d a t e ,  
 	 E n d _ D a t e   	 	 	 	 	 d a t e ,  
 	 E n r o l l m e n t _ V I D   	 	 	 	 i n t e g e r ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e n r o l l m e n t _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e n r o l l m e n t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e n r o l l m e n t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   e n r o l l m e n t _ a k   u n i q u e   (   e n r o l l m e n t _ c o d e ,   e n d _ d a t e   )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . E T L _ T a b l e _ R u n ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . E T L _ T a b l e _ R u n  
 g o    
 c r e a t e   t a b l e   d b o . E T L _ T a b l e _ R u n (  
 	 E T L _ T a b l e _ R u n _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   e t l _ t a b l e _ r u n _ p k   p r i m a r y   k e y ,  
 	 E T L _ T a b l e   	 	 	 	 	 n v a r c h a r ( 1 5 0 ) 	 	 	 n o t   n u l l ,  
 	 S t a t u s _ C o d e 	 	   	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 R o w s _ I n s e r t e d 	 	 	 	 i n t e g e r ,  
 	 R o w s _ U p d a t e d 	 	 	 	 i n t e g e r ,  
 	 R o w s _ D e l e t e d 	 	 	 	 i n t e g e r ,  
 	 S t a r t _ T i m e   	 	 	 	 	 d a t e t i m e ,  
 	 E n d _ T i m e   	 	 	 	 	 d a t e t i m e   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . E v e n t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . E v e n t  
 g o    
 c r e a t e   t a b l e   d b o . E v e n t (  
 	 E v e n t _ K e y   	 	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   e v e n t _ p k   p r i m a r y   k e y ,  
 	 E v e n t _ T y p e _ K e y   	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 E v e n t _ S y s t e m _ K e y   	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 E v e n t   	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) 	 	 	 n o t   n u l l ,  
 	 E v e n t _ D e s c r i p t i o n   	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 T r a c k i n g _ C o d e   	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 C o o r _ U s e r _ K e y   	 	 	 	 i n t e g e r ,  
 	 S t a r t _ D a t e   	 	 	 	 	 d a t e ,  
 	 E n d _ D a t e   	 	 	 	 	 d a t e ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . e v e n t   a d d   c o n s t r a i n t   e v e n t _ f k _ e v e n t _ t y p e   f o r e i g n   k e y   (   e v e n t _ t y p e _ k e y   )   r e f e r e n c e s   d b o . e v e n t _ t y p e (   e v e n t _ t y p e _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . e v e n t   a d d   c o n s t r a i n t   e v e n t _ f k _ e v e n t _ s y s t e m   f o r e i g n   k e y   (   e v e n t _ s y s t e m _ k e y   )   r e f e r e n c e s   d b o . e v e n t _ s y s t e m (   e v e n t _ s y s t e m _ k e y   )  
 g o  
  
 i f   o b j e c t _ i d ( ' d b o . E v e n t _ A t t r i b u t e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . E v e n t _ A t t r i b u t e  
 g o    
 c r e a t e   t a b l e   d b o . E v e n t _ A t t r i b u t e (  
 	 E v e n t _ A t t r i b u t e _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   e v e n t _ a t t r i b u t e _ p k   p r i m a r y   k e y ,  
 	 E v e n t _ K e y   	 	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 E v e n t _ A t t r i b u t e   	 	 	 n v a r c h a r ( 4 0 0 0 ) 	 	 	 n o t   n u l l ,  
 	 E v e n t _ A t t r i b u t e _ G r o u p   	 	 n v a r c h a r ( 2 0 ) ,  
 	 C r e w _ K e y   	 	 	 	 	 i n t e g e r ,  
 	 A t t r i b u t e _ D a t a _ T y p e _ K e y   	 i n t e g e r ,  
 	 A t t r i b u t e _ L O V _ K e y   	 	 	 i n t e g e r ,  
 	 C o l u m n _ N u m b e r   	 	 	 	 i n t e g e r ,  
 	 T O _ P r o f i l e _ A c t i v e _ F l a g   	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ a t t r i b u t e _ t o _ p r o f i l e _ a c t i v e _ f l a g   d e f a u l t   ' N ' ,  
 	 W R K _ E v e n t _ A t t r i b u t e _ K e y 	 	 i n t e g e r ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ a t t r i b u t e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ a t t r i b u t e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ a t t r i b u t e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . e v e n t _ a t t r i b u t e   a d d   c o n s t r a i n t   e v e n t _ a t t r i b u t e _ f k _ e v e n t   f o r e i g n   k e y   (   e v e n t _ k e y   )   r e f e r e n c e s   d b o . e v e n t (   e v e n t _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . e v e n t _ a t t r i b u t e   a d d   c o n s t r a i n t   e v e n t _ a t t r i b u t e _ f k _ a t t r i b u t e _ d a t a _ t y p e   f o r e i g n   k e y   (   a t t r i b u t e _ d a t a _ t y p e _ k e y   )   r e f e r e n c e s   d b o . a t t r i b u t e _ d a t a _ t y p e (   a t t r i b u t e _ d a t a _ t y p e _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . e v e n t _ a t t r i b u t e   a d d   c o n s t r a i n t   e v e n t _ a t t r i b u t e _ f k _ a t t r i b u t e _ l o v   f o r e i g n   k e y   (   a t t r i b u t e _ l o v _ k e y   )   r e f e r e n c e s   d b o . a t t r i b u t e _ l o v (   a t t r i b u t e _ l o v _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . E v e n t _ S y s t e m ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . E v e n t _ S y s t e m  
 g o    
 c r e a t e   t a b l e   d b o . E v e n t _ S y s t e m (  
 	 E v e n t _ S y s t e m _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   e v e n t _ s y s t e m _ p k   p r i m a r y   k e y ,  
 	 E v e n t _ S y s t e m   	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l   c o n s t r a i n t   e v e n t _ s y s t e m _ a k   u n i q u e ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ s y s t e m _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ s y s t e m _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ s y s t e m _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . E v e n t _ T y p e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . E v e n t _ T y p e  
 g o    
 c r e a t e   t a b l e   d b o . E v e n t _ T y p e (  
 	 E v e n t _ T y p e _ K e y   	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   e v e n t _ t y p e _ p k   p r i m a r y   k e y ,  
 	 E v e n t _ T y p e   	 	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l   c o n s t r a i n t   e v e n t _ t y p e _ a k   u n i q u e ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ t y p e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ t y p e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ e v e n t _ t y p e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . H P R _ C r e w ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . H P R _ C r e w  
 g o    
 c r e a t e   t a b l e   d b o . H P R _ C r e w (  
 	 H P R _ C r e w _ K e y 	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   h p r _ c r e w _ p k   p r i m a r y   k e y ,  
 	 H P R _ C r e w _ S h a r e p o i n t _ K e y 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 H P R _ D e p t _ K e y   	 	 	 	 i n t e g e r   	 	 	   	 n o t   n u l l ,  
 	 H P R _ D e p t _ S h a r e p o i n t _ K e y 	 	 n v a r c h a r ( 2 5 5 ) , 	  
 	 C r e w _ N a m e 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) 	 	 	 n o t   n u l l , 	 	 	  
 	 C r e w _ O v s r 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) 	 	 	 n o t   n u l l ,  
 	 C r e w _ O v s r _ P e r s o n _ I D 	 	 	 i n t e g e r ,  
 	 C r e w _ O v s r _ E m a i l 	 	 	 	 n v a r c h a r ( 2 5 5 ) 	 	 	 n o t   n u l l ,  
 	 S t a r t _ D a t e 	 	 	 	 	 d a t e ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ c r e w _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ c r e w _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ c r e w _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   h p r _ c r e w _ a k   u n i q u e   (   h p r _ d e p t _ k e y ,   c r e w _ n a m e   )   )  
 g o  
 	 	  
 a l t e r   t a b l e   d b o . h p r _ c r e w   a d d   c o n s t r a i n t   h p r _ c r e w _ f k _ h p r _ d e p t   f o r e i g n   k e y   (   h p r _ d e p t _ k e y   )   r e f e r e n c e s   d b o . h p r _ d e p t (   h p r _ d e p t _ k e y   )  
 g o 	 	  
  
  
 i f   o b j e c t _ i d ( ' d b o . H P R _ D e p t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . H P R _ D e p t  
 g o    
 c r e a t e   t a b l e   d b o . H P R _ D e p t (  
 	 H P R _ D e p t _ K e y   	 	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   h p r _ d e p t _ p k   p r i m a r y   k e y ,  
 	 H P R _ D e p t _ S h a r e p o i n t _ K e y 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 C P C _ C o d e 	 	 	 	 	 	 n v a r c h a r ( 1 0 ) 	 	 	 n o t   n u l l ,  
 	 D e p t _ N a m e 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 )   	 	 	 n o t   n u l l ,  
 	 W o r k _ G r o u p _ N a m e 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) 	 	 	 n o t   n u l l ,  
 	 C V C _ S h e e t _ N a m e 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 P C _ C o d e 	 	 	 	 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 P C _ C a t e g o r y 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 D e p t _ O v s r 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 D e p t _ O v s r _ P e r s o n _ I D 	 	 	 	 i n t e g e r ,  
 	 D e p t _ O v s r _ E m a i l 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 D e p t _ A s s t _ O v s r 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 D e p t _ A s s t _ O v s r _ P e r s o n _ I D 	 	 i n t e g e r ,  
 	 D e p t _ A s s t _ O v s r _ E m a i l 	 	 	 n v a r c h a r ( 2 5 5 ) , 	  
 	 W o r k _ G r o u p _ O v s r 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 W o r k _ G r o u p _ O v s r _ P e r s o n _ I D 	 	 i n t e g e r ,  
 	 W o r k _ G r o u p _ O v s r _ E m a i l 	 	 	 n v a r c h a r ( 2 5 5 ) , 	  
 	 W o r k _ G r o u p _ A s s t _ O v s r 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 W o r k _ G r o u p _ A s s t _ O v s r _ P e r s o n _ I D 	 i n t e g e r ,  
 	 W o r k _ G r o u p _ A s s t _ O v s r _ E m a i l 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 W o r k _ G r o u p _ C o o r 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 W o r k _ G r o u p _ C o o r _ P e r s o n _ I D 	 	 i n t e g e r ,  
 	 W o r k _ G r o u p _ C o o r _ E m a i l 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 V T C _ C o n t a c t 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 V T C _ 1 _ U s e r _ K e y 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   d e f a u l t   d f _ h p r _ d e p t _ v t c 1   d e f a u l t   1 ,  
 	 V T C _ 2 _ U s e r _ K e y 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   d e f a u l t   d f _ h p r _ d e p t _ v t c 2   d e f a u l t   1 ,  
 	 V T C _ 3 _ U s e r _ K e y 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   d e f a u l t   d f _ h p r _ d e p t _ v t c 3   d e f a u l t   1 ,  
 	 V T C _ 4 _ U s e r _ K e y 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   d e f a u l t   d f _ h p r _ d e p t _ v t c 4   d e f a u l t   1 ,  
 	 V T C _ 5 _ U s e r _ K e y 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   d e f a u l t   d f _ h p r _ d e p t _ v t c 5   d e f a u l t   1 ,  
 	 V T C _ 6 _ U s e r _ K e y 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   d e f a u l t   d f _ h p r _ d e p t _ v t c 6   d e f a u l t   1 ,  
 	 V T C _ 7 _ U s e r _ K e y 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   d e f a u l t   d f _ h p r _ d e p t _ v t c 7   d e f a u l t   1 ,  
 	 V T C _ 8 _ U s e r _ K e y 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   d e f a u l t   d f _ h p r _ d e p t _ v t c 8   d e f a u l t   1 ,  
 	 S t a r t _ D a t e 	 	 	 	 	 	 d a t e ,  
 	 H U B _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ d e p t _ h u b _ f l a g   d e f a u l t   ' N ' ,  
 	 N Y C _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ d e p t _ n y c _ f l a g   d e f a u l t   ' N ' ,  
 	 H U B _ D e p t _ I D 	 	 	 	 	 	 i n t e g e r ,  
 	 L e v e l _ 0 1 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 L e v e l _ 0 2 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) , 	  
 	 L e v e l _ 0 3 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) , 	  
 	 L e v e l _ 0 4 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 L e v e l _ 0 5 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 L e v e l _ 0 6 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 L e v e l _ 0 7 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 L e v e l _ 0 8 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 L e v e l _ 0 9 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) , 	  
 	 L e v e l _ 1 0 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) , 	  
 	 P a r e n t _ H P R _ D e p t _ K e y 	 	 	 	 i n t e g e r ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ d e p t _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ d e p t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ d e p t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   h p r _ d e p t _ a k   u n i q u e   (   d e p t _ n a m e ,   w o r k _ g r o u p _ n a m e   )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . H P R _ D e p t _ R o l e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . H P R _ D e p t _ R o l e  
 g o    
 c r e a t e   t a b l e   d b o . H P R _ D e p t _ R o l e (  
 	 H P R _ D e p t _ R o l e _ K e y 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   h p r _ d e p t _ r o l e _ p k   p r i m a r y   k e y ,  
 	 H P R _ D e p t _ R o l e _ S h a r e p o i n t _ K e y   n v a r c h a r ( 2 5 5 ) ,  
 	 C P C _ C o d e 	 	 	 	 	 n v a r c h a r ( 1 0 ) 	 	 	 n o t   n u l l ,  
 	 D e p t _ R o l e 	 	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ d e p t _ r o l e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ d e p t _ r o l e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ h p r _ d e p t _ r o l e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . M a r i t a l _ S t a t u s ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . M a r i t a l _ S t a t u s  
 g o    
 c r e a t e   t a b l e   d b o . M a r i t a l _ S t a t u s (  
 	 M a r i t a l _ S t a t u s _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   m a r i t a l _ s t a t u s _ p k   p r i m a r y   k e y ,  
 	 M a r i t a l _ S t a t u s _ C o d e   	 	 n v a r c h a r ( 3 0 )   	 	 	 n o t   n u l l   c o n s t r a i n t   m a r i t a l _ s t a t u s _ a k   u n i q u e ,  
 	 M a r i t a l _ S t a t u s   	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l   c o n s t r a i n t   m a r i t a l _ s t a t u s _ a k 2   u n i q u e ,  
 	 M a r i t a l _ S t a t u s _ V I D   	 	 	 i n t e g e r ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ m a r i t a l _ s t a t u s _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ m a r i t a l _ s t a t u s _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ m a r i t a l _ s t a t u s _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . P o s t a l _ C o d e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . P o s t a l _ C o d e  
 g o    
 c r e a t e   t a b l e   d b o . P o s t a l _ C o d e (  
 	 P o s t a l _ C o d e _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   p o s t a l _ c o d e _ p k   p r i m a r y   k e y ,  
 	 P o s t a l _ C o d e   	 	 	 	 n v a r c h a r ( 1 0 )   	 	 	 n o t   n u l l   c o n s t r a i n t   p o s t a l _ c o d e _ a k   u n i q u e ,  
 	 C i t y   	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 S t a t e _ K e y   	 	 	 	 	 i n t e g e r ,  
 	 H P R _ F l a g 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p o s t a l _ c o d e _ h p r _ f l a g   d e f a u l t   ' N ' ,    
 	 L o c a l _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p o s t a l _ c o d e _ l o c a l _ f l a g   d e f a u l t   ' N ' ,  
 	 D r i v i n g _ D i s t a n c e _ F l a g   	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p o s t a l _ c o d e _ d r i v i n g _ d i s t a n c e _ f l a g   d e f a u l t   ' N ' ,  
 	 P A T _ F l a g 	 	 	   	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p o s t a l _ c o d e _ p a t _ f l a g   d e f a u l t   ' N ' ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p o s t a l _ c o d e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p o s t a l _ c o d e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p o s t a l _ c o d e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . P r i o r i t y ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . P r i o r i t y  
 g o    
 c r e a t e   t a b l e   d b o . P r i o r i t y (  
 	 P r i o r i t y _ K e y 	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   p r i o r i t y _ p k   p r i m a r y   k e y ,  
 	 P r i o r i t y 	 	 	 	 	 n v a r c h a r ( 3 0 )   	 	 	 n o t   n u l l ,  
 	 S o r t _ O r d e r 	 	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p r i o r i t y _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p r i o r i t y _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p r i o r i t y _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . P R P ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . P R P  
 g o    
 c r e a t e   t a b l e   d b o . P R P (  
 	 P R P _ K e y   	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   p r p _ p k   p r i m a r y   k e y ,  
 	 H P R _ D e p t _ K e y 	 	 	 i n t e g e r ,  
 	 C a l _ D t 	 	 	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 B e d _ C n t 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 C P C _ C o d e 	 	 	 	 n v a r c h a r ( 1 0 ) ,  
 	 H u B _ D e p t _ N a m e 	 	 	 n v a r c h a r ( 5 0 0 ) ,  
 	 D e p t _ N a m e 	 	 	 	 n v a r c h a r ( 5 0 0 ) ,  
 	 W o r k _ G r o u p _ N a m e 	 	 	 n v a r c h a r ( 5 0 0 ) ,  
 	 P C _ C a t e g o r y 	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 P C _ C o d e 	 	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 P R P _ C n t 	 	 	 	 	 i n t e g e r ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p r p _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . P R P _ B e d _ S p a c e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . P R P _ B e d _ S p a c e  
 g o    
 c r e a t e   t a b l e   d b o . P R P _ B e d _ S p a c e (  
 	 P R P _ B e d _ S p a c e _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   p r p _ b e d _ s p a c e _ p k   p r i m a r y   k e y ,  
 	 C a l _ D t 	 	 	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 R o o m i n g _ C a t e g o r y 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 R o o m i n g _ D e t a i l 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 R e p o r t i n g _ C a t e g o r y 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 B e d _ C n t 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p r p _ b e d _ s p a c e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . P R P _ C P C ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . P R P _ C P C  
 g o    
 c r e a t e   t a b l e   d b o . P R P _ C P C (  
 	 C P C _ C o d e 	 	 	 	 n v a r c h a r ( 1 0 ) 	 	 	 n o t   n u l l ,  
 	 C a l _ D t 	 	 	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 B e d _ C n t 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 P C _ C o d e 	 	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ p r p _ c p c _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . P R P _ C P C   a d d   c o n s t r a i n t   p r p _ c p c _ p k   p r i m a r y   k e y   (   c p c _ c o d e ,   c a l _ d t   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . S k i l l ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . S k i l l  
 g o    
 c r e a t e   t a b l e   d b o . S k i l l (  
 	 S k i l l _ K e y   	 	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   s k i l l _ p k   p r i m a r y   k e y ,  
 	 S k i l l   	 	 	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l ,  
 	 H U B _ S k i l l _ I D 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ h u b _ s k i l l _ i d   d e f a u l t   0 ,  
 	 H U B _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ h u b _ f l a g   d e f a u l t   ' Y ' ,  
 	 B A _ S k i l l _ G U I D 	 	 	 	 u n i q u e i d e n t i f i e r ,  
 	 B A _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ b a _ f l a g   d e f a u l t   ' Y ' ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   s k i l l _ a k   u n i q u e   (   S k i l l ,   A c t i v e _ F l a g   ) )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . S k i l l _ L e v e l ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . S k i l l _ L e v e l  
 g o    
 c r e a t e   t a b l e   d b o . S k i l l _ L e v e l (  
 	 S k i l l _ L e v e l _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   s k i l l _ l e v e l _ p k   p r i m a r y   k e y ,  
 	 S k i l l _ L e v e l _ C o d e   	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l   c o n s t r a i n t   s k i l l _ l e v e l _ a k   u n i q u e ,  
 	 S k i l l _ L e v e l   	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l ,  
 	 S k i l l _ L e v e l _ D e s c   	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ l e v e l _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ l e v e l _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ l e v e l _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . S k i l l _ S p e c i a l i t y ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . S k i l l _ S p e c i a l i t y  
 g o    
 c r e a t e   t a b l e   d b o . S k i l l _ S p e c i a l i t y (  
 	 S k i l l _ S p e c i a l i t y _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   s k i l l _ s p e c i a l i t y _ p k   p r i m a r y   k e y ,  
 	 S k i l l _ K e y   	 	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 S k i l l _ S p e c i a l i t y   	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l ,  
 	 H U B _ S k i l l _ S p e c i a l i t y _ I D   	 i n t e g e r 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ s p e c i a l i t y _ h u b _ s k i l l _ s p e c i a l i t y _ i d   d e f a u l t   0 ,  
 	 H U B _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ s p e c i a l i t y _ h u b _ f l a g   d e f a u l t   ' Y ' ,  
 	 B A _ S u b s k i l l _ G U I D 	 	 	 u n i q u e i d e n t i f i e r ,  
 	 B A _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ s p e c i a l i t y _ b a _ f l a g   d e f a u l t   ' Y ' , 	  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ s p e c i a l i t y _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ s p e c i a l i t y _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s k i l l _ s p e c i a l i t y _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )  
 	 H U B _ S k i l l _ S u b s k i l l _ I D 	 	 i n t e g e r ,  
 	 S k i l l _ S u b s k i l l 	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 B A _ S k i l l _ S p e c i a l i t y _ G U I D 	 u n i q u e i d e n t i f i e r   )  
 g o  
  
 a l t e r   t a b l e   d b o . s k i l l _ s p e c i a l i t y   a d d   c o n s t r a i n t   s k i l l _ s p e c i a l i t y _ f k _ s k i l l   f o r e i g n   k e y   (   s k i l l _ k e y   )   r e f e r e n c e s   d b o . s k i l l (   s k i l l _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . S o u r c e _ S y s t e m ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . S o u r c e _ S y s t e m  
 g o    
 c r e a t e   t a b l e   d b o . S o u r c e _ S y s t e m (  
 	 S o u r c e _ S y s t e m _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   s o u r c e _ s y s t e m _ p k   p r i m a r y   k e y ,  
 	 S o u r c e _ S y s t e m _ C o d e   	 	 	 n v a r c h a r ( 3 0 )   	 	 	 n o t   n u l l   c o n s t r a i n t   s o u r c e _ s y s t e m _ a k   u n i q u e ,  
 	 S o u r c e _ S y s t e m   	 	 	 	 n v a r c h a r ( 1 5 0 )   	 	 	 n o t   n u l l ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s o u r c e _ s y s t e m _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s o u r c e _ s y s t e m _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s o u r c e _ s y s t e m _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . S t a t e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . S t a t e  
 g o    
 c r e a t e   t a b l e   d b o . S t a t e (  
 	 S t a t e _ K e y   	 	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   s t a t e _ p k   p r i m a r y   k e y ,  
 	 S t a t e _ C o d e   	 	 	 	 	 n v a r c h a r ( 3 0 )   	 	 	 n o t   n u l l ,  
 	 S t a t e   	 	 	 	 	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l ,  
 	 C o u n t r y _ K e y   	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 S t a t e _ V I D   	 	 	 	 	 i n t e g e r ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s t a t e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s t a t e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ s t a t e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   s t a t e _ a k   u n i q u e   (   s t a t e _ c o d e ,   c o u n t r y _ k e y   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . s t a t e   a d d   c o n s t r a i n t   s t a t e _ f k _ c o u n t r y   f o r e i g n   k e y   (   c o u n t r y _ k e y   )   r e f e r e n c e s   d b o . c o u n t r y (   c o u n t r y _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . T r a c k i n g _ S t a t u s ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . T r a c k i n g _ S t a t u s  
 g o    
 c r e a t e   t a b l e   d b o . T r a c k i n g _ S t a t u s (  
 	 T r a c k i n g _ S t a t u s _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   t r a c k i n g _ s t a t u s _ p k   p r i m a r y   k e y ,  
 	 T r a c k i n g _ S t a t u s   	 	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l   c o n s t r a i n t   t r a c k i n g _ s t a t u e _ a k   u n i q u e ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ t r a c k i n g _ s t a t u s _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ t r a c k i n g _ s t a t u s _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ t r a c k i n g _ s t a t u s _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . [ U s e r ] ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . [ U s e r ]  
 g o    
 c r e a t e   t a b l e   d b o . [ U s e r ] (  
 	 U s e r _ K e y   	 	 	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   u s e r _ p k   p r i m a r y   k e y ,  
 	 F i r s t _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) 	 	 	 n o t   n u l l ,  
 	 L a s t _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) 	 	 	 n o t   n u l l ,  
 	 E m a i l   	 	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 A D _ U s e r _ N a m e   	 	 	 	 	 n v a r c h a r ( 1 5 0 ) 	 	 	 n o t   n u l l   c o n s t r a i n t   u s e r _ a k   u n i q u e ,  
 	 P C _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 2 5 ) ,  
 	 U s e r _ A c c e s s _ L e v e l _ C o d e   	 	 	 t i n y i n t   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ u s e r _ a c c e s s _ l e v e l _ c o d e _ f l a g   d e f a u l t   9 9 ,  
 	 R e f r e s h _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )     	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ r e f r e s h _ f l a g   d e f a u l t   ' N ' ,  
 	 A d m i n _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 )     	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ a d m i n _ f l a g   d e f a u l t   ' N ' ,  
 	 B e t a _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 )     	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ b e t a _ f l a g   d e f a u l t   ' N ' ,  
 	 V T C _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ v t c _ f l a g   d e f a u l t   ' N ' ,  
 	 V T C _ C P C _ C o d e 	 	 	 	 	 n v a r c h a r ( 3 ) ,  
 	 V T C _ L e v e l _ 0 2 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 T e m p _ D e s k _ F l a g 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ t e m p _ d e s k _ f l a g   d e f a u l t   ' N ' , 	  
 	 U s e r _ D a s h b o a r d _ N a m e 	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 U s e r _ D a s h b o a r d _ N o t e p a d 	 	 	 n v a r c h a r ( m a x ) ,  
 	 U s e r _ D a s h b o a r d _ L a s t _ V i e w _ D a t e 	 d a t e t i m e , 	  
 	 A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . [ U s e r ]   a d d   c o n s t r a i n t   u s e r _ f k _ u s e r _ a c c e s s _ l e v e l   f o r e i g n   k e y   (   u s e r _ a c c e s s _ l e v e l _ c o d e   )   r e f e r e n c e s   d b o . u s e r _ a c c e s s _ l e v e l (   u s e r _ a c c e s s _ l e v e l _ c o d e   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . U s e r _ A c c e s s _ L e v e l ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . U s e r _ A c c e s s _ L e v e l  
 g o    
 c r e a t e   t a b l e   d b o . U s e r _ A c c e s s _ L e v e l (  
 	 U s e r _ A c c e s s _ L e v e l _ C o d e   	 	 t i n y i n t   	 	 	 	 n o t   n u l l   c o n s t r a i n t   u s e r _ a c c e s s _ l e v e l _ p k   p r i m a r y   k e y ,  
 	 U s e r _ A c c e s s _ L e v e l   	 	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l   c o n s t r a i n t   u s e r _ a c c e s s _ l e v e l _ a k   u n i q u e ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ a c c e s s _ l e v e l _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ a c c e s s _ l e v e l _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ a c c e s s _ l e v e l _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . U s e r _ A c t i v i t y ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . U s e r _ A c t i v i t y  
 g o    
 c r e a t e   t a b l e   d b o . U s e r _ A c t i v i t y (  
 	 U s e r _ A c t i v i t y _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   u s e r _ a c t i v i t y _ p k   p r i m a r y   k e y ,  
 	 U s e r _ K e y   	 	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 U s e r _ C o m p u t e r _ N a m e   	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 L o g i n _ D a t e t i m e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ a c t i v i t y _ l o g i n   d e f a u l t   g e t d a t e ( ) ,  
 	 L o g o f f _ D a t e t i m e   	 	 	 d a t e t i m e   )  
 g o  
  
 a l t e r   t a b l e   d b o . u s e r _ a c t i v i t y   a d d   c o n s t r a i n t   u s e r _ a c t i v i t y _ f k _ u s e r   f o r e i g n   k e y   (   u s e r _ k e y   )   r e f e r e n c e s   d b o . [ u s e r ] (   u s e r _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . U s e r _ L i s t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . U s e r _ L i s t  
 g o    
 c r e a t e   t a b l e   d b o . U s e r _ L i s t (  
 	 U s e r _ L i s t _ K e y   	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   u s e r _ l i s t _ p k   p r i m a r y   k e y ,  
 	 U s e r _ K e y   	 	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 U s e r _ L i s t   	 	 	 	 	 n v a r c h a r ( 1 5 0 ) 	 	 	 n o t   n u l l ,  
 	 U s e r _ L i s t _ D e s c r i p t i o n   	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 D e p t _ A s g n _ K e y   	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ d e p t _ a s g n   d e f a u l t   0 ,  
 	 P Q _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ p q _ f l a g   d e f a u l t   ' N ' , 	  
 	 H P R _ D e p t _ K e y 	 	 	 	 i n t e g e r ,  
 	 A c t i v e _ F l a g   	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   u s e r _ l i s t _ a k   u n i q u e   (   u s e r _ k e y ,   u s e r _ l i s t   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . u s e r _ l i s t   a d d   c o n s t r a i n t   u s e r _ l i s t _ f k _ u s e r   f o r e i g n   k e y   (   u s e r _ k e y   )   r e f e r e n c e s   d b o . [ U s e r ] (   u s e r _ k e y   )  
 g o  
  
 a l t e r   t a b l e   d b o . u s e r _ l i s t   w i t h   n o c h e c k   a d d   c o n s t r a i n t   u s e r _ l i s t _ f k _ d e p t _ a s g n   f o r e i g n   k e y   (   d e p t _ a s g n _ k e y   )   r e f e r e n c e s   d b o . d e p t _ a s g n (   d e p t _ a s g n _ k e y   )  
 g o  
  
 a l t e r   t a b l e   d b o . u s e r _ l i s t   n o c h e c k   c o n s t r a i n t   u s e r _ l i s t _ f k _ d e p t _ r o l e  
 g o  
  
 a l t e r   t a b l e   d b o . u s e r _ l i s t   w i t h   n o c h e c k   a d d   c o n s t r a i n t   u s e r _ l i s t _ f k _ h p r _ d e p t   f o r e i g n   k e y   (   p q _ h p r _ d e p t _ k e y   )   r e f e r e n c e s   d b o . h p r _ d e p t (   h p r _ d e p t _ k e y   )  
 g o  
  
 a l t e r   t a b l e   d b o . u s e r _ l i s t   n o c h e c k   c o n s t r a i n t   u s e r _ l i s t _ f k _ h p r _ d e p t  
 g o  
  
 i f   o b j e c t _ i d ( ' d b o . U s e r _ L i s t _ V o l u n t e e r ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . U s e r _ L i s t _ V o l u n t e e r  
 g o    
 c r e a t e   t a b l e   d b o . U s e r _ L i s t _ V o l u n t e e r (  
 	 U s e r _ L i s t _ V o l u n t e e r _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   u s e r _ l i s t _ v o l u n t e e r _ p k   p r i m a r y   k e y ,  
 	 U s e r _ L i s t _ K e y   	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 S o r t _ O r d e r   	 	 	 	 	 	 s m a l l i n t ,  
 	 U s e r _ L i s t _ V o l u n t e e r _ S t a t u s _ K e y 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ v o l u n t e e r _ s t a t u s _ k e y   d e f a u l t   1 ,  
 	 S t a t u s _ D a t e   	 	 	 	 	 d a t e t i m e ,  
 	 N o t e s   	 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 L a s t _ C h a n g e d _ U s e r _ K e y   	 	 	 i n t e g e r ,  
 	 S t a r t _ D a t e 	   	 	 	 	 	 d a t e t i m e ,  
 	 E n d _ D a t e   	 	 	 	 	 	 d a t e t i m e ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ v o l u n t e e r _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ v o l u n t e e r _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ v o l u n t e e r _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   u s e r _ l i s t _ v o l u n t e e r _ a k   u n i q u e   (   u s e r _ l i s t _ k e y ,   v o l u n t e e r _ k e y   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . u s e r _ l i s t _ v o l u n t e e r   a d d   c o n s t r a i n t   u s e r _ l i s t _ v o l u n t e e r _ f k _ u s e r _ l i s t   f o r e i g n   k e y   (   u s e r _ l i s t _ k e y   )   r e f e r e n c e s   d b o . u s e r _ l i s t (   u s e r _ l i s t _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
 a l t e r   t a b l e   d b o . u s e r _ l i s t _ v o l u n t e e r   a d d   c o n s t r a i n t   u s e r _ l i s t _ v o l u n t e e r _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
 a l t e r   t a b l e   d b o . u s e r _ l i s t _ v o l u n t e e r   a d d   c o n s t r a i n t   u s e r _ l i s t _ v o l u n t e e r _ f k _ u s e r _ l i s t _ v o l u n t e e r _ s t a t u s   f o r e i g n   k e y   (   u s e r _ l i s t _ v o l u n t e e r _ s t a t u s _ k e y   )   r e f e r e n c e s   d b o . u s e r _ l i s t _ v o l u n t e e r _ s t a t u s (   u s e r _ l i s t _ v o l u n t e e r _ s t a t u s _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . u s e r _ l i s t _ v o l u n t e e r   a d d   c o n s t r a i n t   u s e r _ l i s t _ v o l u n t e e r _ f k _ u s e r   f o r e i g n   k e y   (   l a s t _ c h a n g e d _ u s e r _ k e y   )   r e f e r e n c e s   d b o . [ U s e r ] (   u s e r _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . U s e r _ L i s t _ V o l u n t e e r _ S t a t u s ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . U s e r _ L i s t _ V o l u n t e e r _ S t a t u s  
 g o    
 c r e a t e   t a b l e   d b o . U s e r _ L i s t _ V o l u n t e e r _ S t a t u s (  
 	 U s e r _ L i s t _ V o l u n t e e r _ S t a t u s _ K e y   	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   u s e r _ l i s t _ v o l u n t e e r _ s t a t u s _ p k   p r i m a r y   k e y ,  
 	 U s e r _ L i s t _ V o l u n t e e r _ S t a t u s   	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l   c o n s t r a i n t   u s e r _ l i s t _ v o l u n t e e r _ s t a t u s _ a k   u n i q u e ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ v o l u n t e e r _ s t a t u s _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ v o l u n t e e r _ s t a t u s _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ l i s t _ v o l u n t e e r _ s t a t u s _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . U s e r _ T a s k ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . U s e r _ T a s k  
 g o    
 c r e a t e   t a b l e   d b o . U s e r _ T a s k (  
 	 U s e r _ T a s k _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   u s e r _ t a s k _ p k   p r i m a r y   k e y ,  
 	 U s e r _ K e y   	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 V o l u n t e e r _ K e y 	 	 	 i n t e g e r ,  
 	 P e r s o n _ N a m e 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 U s e r _ T a s k   	 	 	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ t a s k _ t a s k   d e f a u l t   '   ' ,  
 	 S t a r t _ D a t e 	 	 	 	 d a t e ,  
 	 D u e _ D a t e 	 	 	 	 d a t e ,  
 	 N o t e s 	 	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 U s e r _ T a s k _ S t a t u s _ K e y 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ t a s k _ u s e r _ t a s k _ s t a t u s   d e f a u l t   1 ,  
 	 P r i o r i t y _ K e y 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ t a s k _ p r i o r i t y   d e f a u l t   3 ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ t a s k _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ t a s k _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . u s e r _ t a s k   a d d   c o n s t r a i n t   u s e r _ t a s k _ f k _ u s e r   f o r e i g n   k e y   (   u s e r _ k e y   )   r e f e r e n c e s   d b o . [ U s e r ] (   u s e r _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . u s e r _ t a s k   a d d   c o n s t r a i n t   u s e r _ t a s k _ f k _ u s e r _ t a s k _ s t a t u s   f o r e i g n   k e y   (   u s e r _ t a s k _ s t a t u s _ k e y   )   r e f e r e n c e s   d b o . u s e r _ t a s k _ s t a t u s (   u s e r _ t a s k _ s t a t u s _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . u s e r _ t a s k   a d d   c o n s t r a i n t   u s e r _ t a s k _ f k _ p r i o r i t y   f o r e i g n   k e y   (   p r i o r i t y _ k e y   )   r e f e r e n c e s   d b o . p r i o r i t y (   p r i o r i t y _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . U s e r _ T a s k _ S t a t u s ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . U s e r _ T a s k _ S t a t u s  
 g o    
 c r e a t e   t a b l e   d b o . U s e r _ T a s k _ S t a t u s (  
 	 U s e r _ T a s k _ S t a t u s _ K e y   	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   u s e r _ t a s k _ s t a t u s _ p k   p r i m a r y   k e y ,  
 	 U s e r _ T a s k _ S t a t u s   	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l   c o n s t r a i n t   u s e r _ t a s k _ s t a t u s _ a k   u n i q u e ,  
 	 A c t i v e _ F l a g   	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ t a s k _ s t a t u s _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ t a s k _ s t a t u s _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ u s e r _ t a s k _ s t a t u s _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r (  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ p k   p r i m a r y   k e y ,  
 	 F u l l _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 L a s t _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 F i r s t _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 M i d d l e _ N a m e   	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 P r e f e r r e d _ N a m e   	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 S u f f i x   	 	 	 	 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 M a i d e n _ N a m e   	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 A d d r e s s   	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 A d d r e s s 2   	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 C i t y   	 	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 P o s t a l _ C o d e _ K e y   	 	 	 	 i n t e g e r ,  
 	 S t a t e _ K e y   	 	 	 	 	 	 i n t e g e r ,  
 	 C o u n t r y _ K e y   	 	 	 	 	 i n t e g e r ,  
 	 P r e f e r r e d _ P h o n e   	 	 	 	 n v a r c h a r ( 2 0 ) ,  
 	 P r e f e r r e d _ P h o n e _ T y p e   	 	 	 n v a r c h a r ( 1 5 ) ,  
 	 P r e f e r r e d _ P h o n e _ F o r m a t t e d   	 	 n v a r c h a r ( 3 0 ) ,  
 	 H o m e _ P h o n e   	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 M o b i l e _ P h o n e   	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 E m a i l   	 	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 A l t _ E m a i l   	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 B i r t h _ D a t e   	 	 	 	 	 	 d a t e ,  
 	 B a p t i s m _ D a t e   	 	 	 	 	 d a t e ,  
 	 G e n d e r _ C o d e   	 	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 M a r i t a l _ S t a t u s _ K e y   	 	 	 	 i n t e g e r ,  
 	 R a c e _ C o d e 	 	 	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 C o n g _ S e r v a n t _ C o d e   	 	 	 	 n v a r c h a r ( 3 ) ,  
 	 P i o n e e r _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 C o n g _ K e y   	 	 	 	 	 	 i n t e g e r ,  
 	 T r a d e _ C o n t a c t _ G r o u p _ K e y   	 	 i n t e g e r ,  
 	 C r e w _ K e y   	 	 	 	 	 	 i n t e g e r ,  
 	 V o l _ D e s k _ U s e r _ K e y   	 	 	 	 i n t e g e r ,  
 	 T r a c k i n g _ S t a t u s _ K e y   	 	 	 i n t e g e r ,  
 	 T r a c k i n g _ S t a t u s _ D a t e   	 	 	 d a t e t i m e ,  
 	 T C G _ C o n t a c t   	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 T C G _ C o n t a c t _ N o t e s   	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 T C G _ C o n t a c t _ S t a t u s _ N o t e s 	   	 n v a r c h a r ( 2 5 5 ) ,  
 	 T C G _ C o n t a c t _ D a t e   	 	 	 	 d a t e t i m e ,  
 	 V o l _ D e s k _ N o t e s   	 	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 T r a d e _ O v s r _ N o t e s   	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 A v a i l _ S h o r t _ N o t i c e _ F l a g   	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ T i m e s _ Y r   	 	 	 	 	 i n t e g e r ,  
 	 B A _ V o l u n t e e r _ I D 	 	 	 	 	 b i g i n t ,  
 	 B A _ V o l u n t e e r _ N u m   	 	 	 	 i n t e g e r ,  
 	 B A _ A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 B A _ P r o f i l e _ C r e a t e d _ F l a g   	 	 n v a r c h a r ( 1 ) ,  
 	 B A _ P r o f i l e _ C r e a t e _ D a t e   	 	 	 d a t e t i m e ,  
 	 B A _ S a f e t y _ O r i e n t a t i o n _ D a t e 	 	 d a t e ,  
 	 H U B _ P e r s o n _ I D   	 	 	 	 	 i n t e g e r ,  
 	 H U B _ P e r s o n _ G U I D 	 	 	 	 	 u n i q u e i d e n t i f i e r ,  
 	 H U B _ V o l u n t e e r _ N u m 	 	 	 	 i n t e g e r ,  
 	 H U B _ V o l u n t e e r _ I D 	 	 	 	 i n t e g e r ,  
 	 H U B _ T r a c k i n g _ F l a g 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ t r a c k i n g _ f l a g   d e f a u l t   ' N ' ,  
 	 J W _ U s e r _ C o d e   	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 J W _ U s e r n a m e   	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 M a t e _ B A _ V o l u n t e e r _ I D 	 	 	 b i g i n t ,  
 	 M a t e _ B A _ V o l u n t e e r _ N u m   	 	 	 i n t e g e r ,  
 	 M a t e _ H U B _ P e r s o n _ I D   	 	 	 	 i n t e g e r ,  
 	 M a t e _ H U B _ P e r s o n _ G U I D 	 	 	 u n i q u e i d e n t i f i e r ,  
 	 A 8 _ A p p r o v e d _ F l a g   	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a 8 _ a p p r o v e d _ f l a g   d e f a u l t   ' N ' ,  
 	 A 8 _ A p p _ S t a t u s _ K e y   	 	 	 	 i n t e g e r ,  
 	 A 8 _ A p p _ D a t e   	 	 	 	 	 d a t e ,  
 	 A 1 9 _ A p p r o v e d _ F l a g   	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a 1 9 _ a p p r o v e d _ f l a g   d e f a u l t   ' N ' ,  
 	 A 1 9 _ A p p _ S t a t u s _ K e y   	 	 	 	 i n t e g e r ,  
 	 A 1 9 _ A p p _ D a t e   	 	 	 	 	 d a t e ,  
 	 A p p _ R e q u e s t _ C o l l e c t i o n _ F l a g 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a p p _ c o l l e c t i o n _ f l a g   d e f a u l t   ' N ' ,  
 	 P e r s o n _ K e y _ R o l e s _ F l a g 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ p e r s o n _ k e y _ r o l e s _ f l a g   d e f a u l t   ' N ' , 	  
 	 H P R _ V o l u n t e e r _ E x c e p t i o n _ F l a g 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ h p r _ v o l u n t e e r _ f l a g   d e f a u l t   ' N ' ,  
 	 S t a f f i n g _ N u m b e r _ E x c e p t i o n _ F l a g 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s t a f f i n g _ n u m b e r _ f l a g   d e f a u l t   ' - ' ,  
 	 A p p _ P u r s u e d _ B y _ V a l u e 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 C u r r e n t _ E n r o l l m e n t _ K e y   	 	 	 i n t e g e r ,  
 	 C u r r e n t _ E n r o l l m e n t _ S t a r t _ D a t e 	 d a t e t i m e ,  
 	 C u r r e n t _ E n r o l l m e n t _ E n d _ D a t e   	 d a t e t i m e ,  
 	 T e n t a t i v e _ E n d _ D a t e 	 	 	 	 d a t e ,  
 	 R V D _ B a n n e r 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 W h a t s A p p _ F l a g 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ w h a t s a p p _ f l a g   d e f a u l t   ' N ' ,  
 	 S M S _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s m s _ f l a g   d e f a u l t   ' N ' ,  
 	 C o n g _ R e l o c a t i o n _ D a t e 	 	 	 d a t e ,  
 	 C o n g _ R e l o c a t i o n _ L a s t _ U p d a t e d _ B y 	 n v a r c h a r ( 1 0 0 ) ,  
 	 R o o m _ S i t e _ C o d e 	 	 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 R o o m _ B l d g 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 R o o m _ B l d g _ C o d e 	 	 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 R o o m 	 	 	 	 	 	 	 n v a r c h a r ( 3 0 ) , 	  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r   a d d   c o n s t r a i n t   v o l u n t e e r _ f k _ p o s t a l _ c o d e   f o r e i g n   k e y   (   p o s t a l _ c o d e _ k e y   )   r e f e r e n c e s   d b o . p o s t a l _ c o d e (   p o s t a l _ c o d e _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r   a d d   c o n s t r a i n t   v o l u n t e e r _ f k _ s t a t e   f o r e i g n   k e y   (   s t a t e _ k e y   )   r e f e r e n c e s   d b o . s t a t e (   s t a t e _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r   a d d   c o n s t r a i n t   v o l u n t e e r _ f k _ c o u n t r y   f o r e i g n   k e y   (   c o u n t r y _ k e y   )   r e f e r e n c e s   d b o . c o u n t r y (   c o u n t r y _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r   a d d   c o n s t r a i n t   v o l u n t e e r _ f k _ m a r i t a l _ s t a t u s   f o r e i g n   k e y   (   m a r i t a l _ s t a t u s _ k e y   )   r e f e r e n c e s   d b o . m a r i t a l _ s t a t u s (   m a r i t a l _ s t a t u s _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r   a d d   c o n s t r a i n t   v o l u n t e e r _ f k _ c o n g   f o r e i g n   k e y   (   c o n g _ k e y   )   r e f e r e n c e s   d b o . c o n g (   c o n g _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r   a d d   c o n s t r a i n t   v o l u n t e e r _ f k _ u s e r   f o r e i g n   k e y   (   v o l _ d e s k _ u s e r _ k e y   )   r e f e r e n c e s   d b o . [ U s e r ] (   u s e r _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r   a d d   c o n s t r a i n t   v o l u n t e e r _ f k _ t r a c k i n g _ s t a t u s   f o r e i g n   k e y   (   t r a c k i n g _ s t a t u s _ k e y   )   r e f e r e n c e s   d b o . t r a c k i n g _ s t a t u s (   t r a c k i n g _ s t a t u s _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ A p p ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ A p p  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ A p p (  
 	 V o l u n t e e r _ A p p _ K e y   	 	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ a p p _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 A p p _ T y p e _ K e y   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 A p p _ S t a t u s _ K e y   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 A p p _ D a t e   	 	 	 	 	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 E x p i r a t i o n _ D a t e   	 	 	 	 	 d a t e 	   	 	 	 	 n o t   n u l l ,  
 	 S t a t u s _ N o t e s   	 	 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 A p p _ N o t e s   	 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 R e v i e w _ S t a t u s _ S u b m i t t e d _ D a t e 	 	 d a t e t i m e ,    
 	 R e v i e w _ S t a g e _ E l d e r s _ D a t e   	 	 	 d a t e t i m e ,    
 	 R e v i e w _ S t a g e _ C O _ D a t e   	 	 	 	 d a t e t i m e ,  
 	 A t t r i b _ A p p r o v a l _ L e v e l _ A p p _ A t t r i b _ I D 	 i n t e g e r , 	  
 	 A t t r i b _ A p p r o v a l _ L e v e l _ A t t r i b _ I D 	 	 i n t e g e r ,  
 	 A t t r i b _ A p p r o v a l _ L e v e l _ V a l 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 A t t r i b _ P u r s u e d _ B y _ A p p _ A t t r i b _ I D 	 	 i n t e g e r , 	  
 	 A t t r i b _ P u r s u e d _ B y _ A t t r i b _ I D 	 	 	 i n t e g e r , 	  
 	 A t t r i b _ P u r s u e d _ B y _ V a l 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 A t t r i b _ C o n t a c t e d _ A p p _ A t t r i b _ I D 	 	 i n t e g e r , 	 	  
 	 A t t r i b _ C o n t a c t e d _ A t t r i b _ I D 	 	 	 i n t e g e r , 	  
 	 A t t r i b _ C o n t a c t e d _ V a l 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 A t t r i b _ S K E _ A p p _ A t t r i b _ I D 	 	 	 i n t e g e r , 	 	  
 	 A t t r i b _ S K E _ A t t r i b _ I D 	 	 	 	 i n t e g e r , 	  
 	 A t t r i b _ S K E _ V a l 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 A t t r i b _ O t h e r _ A p p _ A t t r i b _ I D 	 	 	 i n t e g e r , 	  
 	 A t t r i b _ O t h e r _ A t t r i b _ I D 	 	 	 	 i n t e g e r ,  
 	 A t t r i b _ O t h e r _ V a l 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 A p p l i c a n t _ I D   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ a p p _ a k   u n i q u e ,  
 	 E x p i r e d _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a p p _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a p p _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a p p _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ a p p   a d d   c o n s t r a i n t   v o l u n t e e r _ a p p _ f k _ a p p _ t y p e   f o r e i g n   k e y   (   a p p _ t y p e _ k e y   )   r e f e r e n c e s   d b o . a p p _ t y p e (   a p p _ t y p e _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ a p p   a d d   c o n s t r a i n t   v o l u n t e e r _ a p p _ f k _ a p p _ s t a t u s   f o r e i g n   k e y   (   a p p _ s t a t u s _ k e y   )   r e f e r e n c e s   d b o . a p p _ s t a t u s (   a p p _ s t a t u s _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ a p p   a d d   c o n s t r a i n t   v o l u n t e e r _ a p p _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ A p p r o v a l _ L e v e l _ H i s t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ A p p r o v a l _ L e v e l _ H i s t  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ A p p r o v a l _ L e v e l _ H i s t (  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 A p p r o v a l _ L e v e l 	 	 	 	 	 	 n v a r c h a r ( 3 0 ) 	 	 	 n o t   n u l l ,  
 	 S t a r t _ D a t e   	 	 	 	 	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 E n d _ D a t e   	 	 	 	 	 	 	 d a t e ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a p p r o v a l _ l e v e l _ h i s t _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a p p r o v a l _ l e v e l _ h i s t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a p p r o v a l _ l e v e l _ h i s t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   v o l u n t e e r _ a p p r o v a l _ l e v e l _ h i s t _ a k   u n i q u e   (   v o l u n t e e r _ k e y ,   a p p r o v a l _ l e v e l ,   s t a r t _ d a t e   )   )  
 g o 	  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ a p p r o v a l _ l e v e l _ h i s t   a d d   c o n s t r a i n t   v o l u n t e e r _ a p p r o v a l _ l e v e l _ h i s t _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
 	  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ A v a i l a b i l i t y ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ A v a i l a b i l i t y  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ A v a i l a b i l i t y (  
 	 V o l u n t e e r _ A v a i l a b i l i t y _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ a v a i l a b i l i t y _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ a v a i l a b i l i t y _ a k   u n i q u e ,  
 	 A v a i l _ A s _ C o n s u l t a n t _ F l a g 	 	 	 n v a r c h a r ( 1 ) ,    
 	 A v a i l _ A s _ C o m m u t e r _ F l a g   	 	 	 	 n v a r c h a r ( 1 ) ,    
 	 A v a i l _ A s _ C o m m u t e r _ A s _ N e e d e d _ F l a g 	 n v a r c h a r ( 1 ) ,    
 	 A v a i l _ A s _ C o m m u t e r _ C l o s e s t _ S i t e   	 	 n v a r c h a r ( 1 0 0 0 ) ,    
 	 A v a i l _ A s _ C o m m u t e r _ D a y s _ P e r _ W k   	 	 d e c i m a l ( 6 , 1 ) ,    
 	 A v a i l _ A s _ C o m m u t e r _ W e e k l y _ F l a g 	 	 n v a r c h a r ( 1 ) ,    
 	 A v a i l _ A s _ C o m m u t e r _ N o t e s   	 	 	 n v a r c h a r ( 4 0 0 0 ) ,    
 	 A v a i l _ A s _ C o m m u t e r _ M o n _ A M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ M o n _ P M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ T u e _ A M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ T u e _ P M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ W e d _ A M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ W e d _ P M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ T h u _ A M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ T h u _ P M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ F r i _ A M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ F r i _ P M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ S a t _ A M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ S a t _ P M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ S u n _ A M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ C o m m u t e r _ S u n _ P M _ F l a g 	 	 n v a r c h a r ( 1 ) ,  
 	 A v a i l _ A s _ R e m o t e _ V o l _ F l a g 	 	 	 n v a r c h a r ( 1 ) ,    
 	 A v a i l _ A s _ R e m o t e _ V o l _ D a y s _ P e r _ W k   	 t i n y i n t ,    
 	 A v a i l _ A s _ R e m o t e _ V o l _ N o t e s   	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 A v a i l _ A s _ V o l _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 ) ,    
 	 A v a i l _ A s _ V o l _ A n y t i m e _ F l a g 	 	 	 n v a r c h a r ( 1 ) ,    
 	 A v a i l _ A s _ V o l _ S t a r t _ D a t e   	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 A v a i l _ A s _ V o l _ E n d _ D a t e   	 	 	 	 d a t e ,  
 	 A v a i l _ A s _ V o l _ D a t e _ N o t e s   	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 A v a i l _ A s _ V o l _ D a t e _ S h o r t _ T e r m _ D a y s   	 i n t e g e r ,    
 	 A v a i l _ A s _ V o l _ L o n g _ T e r m _ F l a g   	 	 n v a r c h a r ( 1 ) ,    
 	 A v a i l _ A s _ V o l _ N o t e s 	 	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a v a i l a b i l i t y _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a v a i l a b i l i t y _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ a v a i l a b i l i t y _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 L a s t _ U p d a t e _ D a t e 	 	 	 	 	 d a t e t i m e   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ a v a i l a b i l i t y   a d d   c o n s t r a i n t   v o l u n t e e r _ a v a i l a b i l i t y _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ C o n t a c t _ H i s t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ C o n t a c t _ H i s t  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ C o n t a c t _ H i s t (  
 	 V o l u n t e e r _ C o n t a c t _ H i s t _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ c o n t a c t _ h i s t _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 V T C _ N a m e 	 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) 	 	 	 n o t   n u l l ,  
 	 C o n t a c t _ D a t e 	 	 	 	 	 	 d a t e ,  
 	 C o n t a c t _ T y p e 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 C o n t a c t _ P u r p o s e 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 C o n t a c t _ P e n d i n g 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 C o n t a c t _ N o t e s 	 	 	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 C o n t a c t _ U R L 	 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) , 	  
 	 A t t r i b u t e _ V a l u e 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) , 	  
 	 A c t i v e _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ c o n t a c t _ h i s t _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ c o n t a c t _ h i s t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ c o n t a c t _ h i s t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ c o n t a c t _ h i s t   a d d   c o n s t r a i n t   v o l u n t e e r _ c o n t a c t _ h i s t _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ D e p t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ D e p t  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ D e p t (  
 	 V o l u n t e e r _ D e p t _ K e y   	 	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ d e p t _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 P e r s o n _ I D 	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 S i t e _ C o d e   	 	 	 	 	 	 n v a r c h a r ( 1 0 ) ,  
 	 P a r e n t _ D e p t _ N a m e 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 D e p t _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) 	 	 	 n o t   n u l l ,  
 	 T e m p _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ t e m p _ f l a g   d e f a u l t   ' N ' ,  
 	 P r i m a r y _ F l a g 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ p r i m a r y _ f l a g   d e f a u l t   ' Y ' ,  
 	 S p l i t _ A l l o c a t i o n _ P c t 	 	 	 i n t e g e r ,  
 	 E n r o l l m e n t _ C o d e   	 	 	 	 n v a r c h a r ( 5 ) ,  
 	 D e p t _ R o l e 	 	 	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 S t a r t _ D a t e   	 	 	 	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 E n d _ D a t e   	 	 	 	 	 	 d a t e ,  
 	 N o t e s 	 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 M o n _ A M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ m o n _ a m _ f l a g   d e f a u l t   ' N ' ,  
 	 M o n _ P M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ m o n _ p m _ f l a g   d e f a u l t   ' N ' ,  
 	 T u e _ A M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ t u e _ a m _ f l a g   d e f a u l t   ' N ' ,  
 	 T u e _ P M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ t u e _ p m _ f l a g   d e f a u l t   ' N ' ,  
 	 W e d _ A M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ w e d _ a m _ f l a g   d e f a u l t   ' N ' ,  
 	 W e d _ P M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ w e d _ p m _ f l a g   d e f a u l t   ' N ' ,  
 	 T h u _ A M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ t h u _ a m _ f l a g   d e f a u l t   ' N ' ,  
 	 T h u _ P M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ t h u _ p m _ f l a g   d e f a u l t   ' N ' ,  
 	 F r i _ A M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ f r i _ a m _ f l a g   d e f a u l t   ' N ' ,  
 	 F r i _ P M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ f r i _ p m _ f l a g   d e f a u l t   ' N ' ,  
 	 S a t _ A M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ s a t _ a m _ f l a g   d e f a u l t   ' N ' ,  
 	 S a t _ P M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ s a t _ p m _ f l a g   d e f a u l t   ' N ' ,  
 	 S u n _ A M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ s u n _ a m _ f l a g   d e f a u l t   ' N ' ,  
 	 S u n _ P M _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ s u n _ p m _ f l a g   d e f a u l t   ' N ' ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ a c t i v e _ f l a g   d e f a u l t   ' N ' ,  
 	 W R K _ C r e w 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 W R K _ R o l e 	 	 	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 W R K _ P r i v   	 	 	 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 H U B _ D e p t _ I D 	 	 	 	 	 	 i n t e g e r , 	  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ d e p t   a d d   c o n s t r a i n t   v o l u n t e e r _ d e p t _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ D e p t _ R p t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ D e p t _ R p t  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ D e p t _ R p t (  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 F u l l _ N a m e 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 H U B _ D e p t _ I D 	 	 	 	 	 	 i n t e g e r ,  
 	 P a r e n t _ D e p t _ N a m e 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 D e p t _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) 	 	 	 n o t   n u l l ,  
 	 T e m p _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ r p t _ t e m p _ f l a g   d e f a u l t   ' N ' ,  
 	 P r i m a r y _ F l a g 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ d e p t _ r p t _ p r i m a r y _ f l a g   d e f a u l t   ' Y ' ,    
 	 S p l i t _ A l l o c a t i o n _ P c t 	 	 	 i n t e g e r ,  
 	 S t a r t _ D a t e   	 	 	 	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 E n d _ D a t e 	 	 	 	 	 	 d a t e ,  
 	 H P R _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l ,  
 	 M o n _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l ,  
 	 T u e _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l ,  
 	 W e d _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l ,  
 	 T h u _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l ,  
 	 F r i _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l ,  
 	 S a t _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l ,  
 	 S u n _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l , 	  
 	 R o w _ N u m 	 	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ E n r o l l m e n t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ E n r o l l m e n t  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ E n r o l l m e n t (  
 	 V o l u n t e e r _ E n r o l l m e n t _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ e n r o l l m e n t _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 E n r o l l m e n t _ K e y   	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 G e o _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 5 0 ) ,  
 	 S i t e _ C o d e   	 	 	 	 	 	 n v a r c h a r ( 1 0 ) ,  
 	 D e p t _ C o d e   	 	 	 	 	 	 n v a r c h a r ( 3 0 ) ,  
 	 D e p t _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) ,  
 	 N o t e s   	 	 	 	 	 	 	 n v a r c h a r ( m a x ) ,  
 	 A p p l i c a n t _ I D 	 	 	 	 	 i n t e g e r ,  
 	 S t a r t _ D a t e   	 	 	 	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 E n d _ D a t e   	 	 	 	 	 	 d a t e ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ e n r o l l m e n t _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ e n r o l l m e n t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ e n r o l l m e n t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 	 - - c o n s t r a i n t   v o l u n t e e r _ e n r o l l m e n t _ a k   u n i q u e   (   v o l u n t e e r _ k e y ,   e n r o l l m e n t _ k e y ,   s t a r t _ d a t e   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ e n r o l l m e n t   a d d   c o n s t r a i n t   v o l u n t e e r _ e n r o l l m e n t _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ e n r o l l m e n t   a d d   c o n s t r a i n t   v o l u n t e e r _ e n r o l l m e n t _ f k _ e n r o l l m e n t   f o r e i g n   k e y   (   e n r o l l m e n t _ k e y   )   r e f e r e n c e s   d b o . e n r o l l m e n t (   e n r o l l m e n t _ k e y   )  
 g o  
 c r e a t e   i n d e x   v o l u n t e e r _ e n r o l l m e n t _ i d x _ g e o _ s t a r t _ d t   o n   d b o . v o l u n t e e r _ e n r o l l m e n t (   g e o _ n a m e ,   s t a r t _ d a t e   )  
 	 i n c l u d e (   v o l u n t e e r _ k e y ,   e n r o l l m e n t _ k e y ,   s i t e _ c o d e ,   e n d _ d a t e ,   a c t i v e _ f l a g   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ E n r o l l m e n t _ R p t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ E n r o l l m e n t _ R p t  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ E n r o l l m e n t _ R p t (  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 F u l l _ N a m e 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 E n r o l l m e n t _ K e y   	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 E n r o l l m e n t _ C o d e 	 	 	 	 	 n v a r c h a r ( 3 0 ) 	 	 	 n o t   n u l l ,  
 	 E n r o l l m e n t _ S i t e _ C o d e 	 	 	 n v a r c h a r ( 1 0 ) ,  
 	 S t a r t _ D a t e   	 	 	 	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 E n d _ D a t e   	 	 	 	 	 	 d a t e ,  
 	 R o w _ N u m 	 	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ E v e n t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ E v e n t  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ E v e n t (  
 	 V o l u n t e e r _ E v e n t _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ e v e n t _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 E v e n t _ K e y   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 V o l _ D e s k _ U s e r _ K e y   	 	 	 	 i n t e g e r ,  
 	 N o t e s   	 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 F i l e _ U R L   	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 S t a r t _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ e v e n t _ s t a r t _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 R e s p o n s e _ D a t e   	 	 	 	 	 d a t e t i m e ,  
 	 W R K _ V o l u n t e e r _ E v e n t _ K e y   	 	 i n t e g e r ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ e v e n t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ e v e n t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   ) 	  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ e v e n t   a d d   c o n s t r a i n t   v o l u n t e e r _ e v e n t _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ e v e n t   a d d   c o n s t r a i n t   v o l u n t e e r _ e v e n t _ f k _ e v e n t   f o r e i g n   k e y   (   e v e n t _ k e y   )   r e f e r e n c e s   d b o . e v e n t (   e v e n t _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ e v e n t   a d d   c o n s t r a i n t   v o l u n t e e r _ e v e n t _ f k _ u s e r   f o r e i g n   k e y   (   v o l _ d e s k _ u s e r _ k e y   )   r e f e r e n c e s   d b o . [ u s e r ] (   u s e r _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ E v e n t _ D a t a ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ E v e n t _ D a t a  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ E v e n t _ D a t a (  
 	 V o l u n t e e r _ E v e n t _ D a t a _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ e v e n t _ d a t a _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ E v e n t _ K e y   	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 E v e n t _ A t t r i b u t e _ K e y   	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 E v e n t _ D a t a   	 	 	 	 	 	 n v a r c h a r ( 4 0 0 0 )   	 	 	 n o t   n u l l ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ e v e n t _ d a t a _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ e v e n t _ d a t a _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   v o l u n t e e r _ e v e n t _ d a t a _ a k   u n i q u e   (   v o l u n t e e r _ e v e n t _ k e y ,   e v e n t _ a t t r i b u t e _ k e y   )   ) 	  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ e v e n t _ d a t a   a d d   c o n s t r a i n t   v o l u n t e e r _ e v e n t _ d a t a _ f k _ v o l u n t e e r _ e v e n t   f o r e i g n   k e y   (   v o l u n t e e r _ e v e n t _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r _ e v e n t (   v o l u n t e e r _ e v e n t _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ e v e n t _ d a t a   a d d   c o n s t r a i n t   v o l u n t e e r _ e v e n t _ d a t a _ f k _ e v e n t _ a t t r i b u t e   f o r e i g n   k e y   (   e v e n t _ a t t r i b u t e _ k e y   )   r e f e r e n c e s   d b o . e v e n t _ a t t r i b u t e (   e v e n t _ a t t r i b u t e _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ F T S ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ F T S  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ F T S (  
 	 V o l u n t e e r _ K e y 	 	 	 	 i n t e g e r 	 	 	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ f t s _ p k   p r i m a r y   k e y ,  
 	 F T S 	 	 	 	 	 	 	 n u m e r i c ( 1 8 , 6 ) ,  
 	 S F T S 	 	 	 	 	 	 n u m e r i c ( 1 8 , 6 ) ,  
 	 R o u n d e d _ F T S 	 	 	 	 	 i n t e g e r ,  
 	 R o u n d e d _ S F T S 	 	 	 	 i n t e g e r   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ f t s   a d d   c o n s t r a i n t   v o l u n t e e r _ f t s _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ P u r s u i t _ C a n c e l _ R e a s o n ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ P u r s u i t _ C a n c e l _ R e a s o n  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ P u r s u i t _ C a n c e l _ R e a s o n (  
 	 V o l u n t e e r _ P u r s u i t _ C a n c e l _ R e a s o n _ K e y   	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ p u r s u i t _ c a n c e l _ r e a s o n _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ P u r s u i t _ C a n c e l _ R e a s o n _ C o d e 	 n v a r c h a r ( 1 0 0 ) 	 	 	 n o t   n u l l ,  
 	 S o r t _ O r d e r 	 	 	 	 	 	 	 	 s m a l l i n t ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ p u r s u i t _ c a n c e l _ r e a s o n _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ p u r s u i t _ c a n c e l _ r e a s o n _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ p u r s u i t _ c a n c e l _ r e a s o n _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   v o l u n t e e r _ p u r s u i t _ c a n c e l _ r e a s o n _ a k   u n i q u e   (   V o l u n t e e r _ P u r s u i t _ C a n c e l _ R e a s o n _ C o d e   )   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ P u r s u i t _ H i s t ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ P u r s u i t _ H i s t  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ P u r s u i t _ H i s t (  
 	 V o l u n t e e r _ P u r s u i t _ H i s t _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ p u r s u i t _ h i s t _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 V T C _ N a m e 	 	 	 	 	 	 	 n v a r c h a r ( 1 0 0 ) 	 	 	 n o t   n u l l ,  
 	 H P R _ D e p t _ K e y 	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 S t a r t _ D a t e 	 	 	 	 	 	 	 d a t e ,  
 	 T a r g e t _ D a t e 	 	 	 	 	 	 	 d a t e ,  
 	 R o l e _ N a m e 	 	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 R o l e _ D e s c 	 	 	 	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 A t t r i b u t e _ V a l u e 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 R e q u e s t e d _ F l a g 	 	 	 	 	 	 n v a r c h a r ( 1 ) 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ p u r s u i t _ h i s t _ r e q u e s t e d _ f l a g   d e f a u l t   ' N ' ,  
 	 V o l u n t e e r _ P u r s u i t _ C a n c e l _ R e a s o n _ K e y 	 i n t e g e r ,  
 	 R e q u e s t _ C a n c e l _ R e a s o n 	 	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ p u r s u i t _ h i s t _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ p u r s u i t _ h i s t _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ p u r s u i t _ h i s t _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   v o l u n t e e r _ p u r s u i t _ h i s t _ a k   u n i q u e   (   v o l u n t e e r _ k e y ,   h p r _ d e p t _ k e y ,   s t a r t _ d a t e   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ p u r s u i t _ h i s t   a d d   c o n s t r a i n t   v o l u n t e e r _ p u r s u i t _ h i s t _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ p u r s u i t _ h i s t   a d d   c o n s t r a i n t   v o l u n t e e r _ p u r s u i t _ h i s t _ f k _ h p r _ d e p t   f o r e i g n   k e y   (   h p r _ d e p t _ k e y   )   r e f e r e n c e s   d b o . h p r _ d e p t (   h p r _ d e p t _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ p u r s u i t _ h i s t   a d d   c o n s t r a i n t   v o l u n t e e r _ p u r s u i t _ h i s t _ f k _ v o l u n t e e r _ p u r s u i t _ c a n c e l _ r e a s o n   f o r e i g n   k e y   (   v o l u n t e e r _ p u r s u i t _ c a n c e l _ r e a s o n _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r _ p u r s u i t _ c a n c e l _ r e a s o n (   v o l u n t e e r _ p u r s u i t _ c a n c e l _ r e a s o n _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ R o l e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ R o l e  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ R o l e (  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 R o l e 	 	 	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) 	 	 	 n o t   n u l l ,  
 	 R o l e _ D a t a 	 	 	 	 	 	 	 n v a r c h a r ( 1 5 0 ) ,  
 	 S t a r t _ D a t e   	 	 	 	 	 	 	 d a t e 	 	 	 	 	 n o t   n u l l ,  
 	 E n d _ D a t e   	 	 	 	 	 	 	 d a t e ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ r o l e _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ r o l e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ r o l e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   v o l u n t e e r _ r o l e _ a k   u n i q u e   (   v o l u n t e e r _ k e y ,   r o l e ,   s t a r t _ d a t e   )   )  
 g o 	  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ r o l e   a d d   c o n s t r a i n t   v o l u n t e e r _ r o l e _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ S e a r c h _ P h o n e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ S e a r c h _ P h o n e  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ S e a r c h _ P h o n e (  
 	 V o l u n t e e r _ K e y   	 	 	 i n t e g e r   	 	 n o t   n u l l ,  
 	 P h o n e _ N u m 	 	 	 	 n v a r c h a r ( 1 0 0 ) 	 n o t   n u l l ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 	 	 d a t e t i m e   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ p h o n e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( )  
 	 c o n s t r a i n t   v o l u n t e e r _ s e a r c h _ p h o n e _ p k   p r i m a r y   k e y   (   v o l u n t e e r _ k e y ,   p h o n e _ n u m   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ s e a r c h _ p h o n e   a d d   c o n s t r a i n t   v o l u n t e e r _ s e a r c h _ p h o n e _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ S e a r c h _ S a v e ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ S e a r c h _ S a v e  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ S e a r c h _ S a v e (  
 	 V o l u n t e e r _ S e a r c h _ S a v e _ K e y   	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ s e a r c h _ s a v e _ p k   p r i m a r y   k e y ,  
 	 U s e r _ K e y   	 	 	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 S e a r c h _ T i m e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l ,  
 	 D e s c r i p t i o n   	 	 	 	 	 n v a r c h a r ( 2 5 5 )   	 	 	 n o t   n u l l ,  
 	 c m b S k i l l _ K e y   	 	 	 	 	 i n t e g e r ,  
 	 c m b S k i l l _ S p e c i a l i t y _ K e y   	 	 i n t e g e r ,  
 	 c m b S k i l l _ L e v e l _ K e y   	 	 	 	 i n t e g e r ,  
 	 c m b S k i l l _ K e y _ 2   	 	 	 	 	 i n t e g e r ,  
 	 c m b S k i l l _ S p e c i a l i t y _ K e y _ 2   	 	 i n t e g e r ,  
 	 c m b S k i l l _ L e v e l _ K e y _ 2 	 	 	 i n t e g e r ,  
 	 c m b S k i l l _ K e y _ 3   	 	 	 	 	 i n t e g e r ,  
 	 c m b S k i l l _ S p e c i a l i t y _ K e y _ 3   	 	 i n t e g e r ,  
 	 c m b S k i l l _ L e v e l _ K e y _ 3 	 	 	 i n t e g e r ,  
 	 c m b S k i l l _ K e y _ 4   	 	 	 	 	 i n t e g e r ,  
 	 c m b S k i l l _ S p e c i a l i t y _ K e y _ 4   	 	 i n t e g e r ,  
 	 c m b S k i l l _ L e v e l _ K e y _ 4 	 	 	 i n t e g e r ,  
 	 c m b S k i l l _ K e y _ 5   	 	 	 	 	 i n t e g e r ,  
 	 c m b S k i l l _ S p e c i a l i t y _ K e y _ 5   	 	 i n t e g e r ,  
 	 c m b S k i l l _ L e v e l _ K e y _ 5 	 	 	 i n t e g e r ,  
 	 t x t A v a i l D a t e   	 	 	 	 	 d a t e ,  
 	 c m b G e n d e r   	 	 	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 c m b S e r v a n t   	 	 	 	 	 	 n v a r c h a r ( 2 ) ,  
 	 c m b M a r i t a l S t a t u s   	 	 	 	 n v a r c h a r ( 2 ) ,  
 	 c m b P i o n e e r   	 	 	 	 	 	 n v a r c h a r ( 2 ) ,  
 	 c m b A g e F r o m   	 	 	 	 	 	 t i n y i n t ,  
 	 c m b A g e T o   	 	 	 	 	 	 t i n y i n t ,  
 	 c m b L o c a l   	 	 	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 c m b D r i v i n g D i s t a n c e   	 	 	 	 n v a r c h a r ( 1 ) ,  
 	 t x t T C G D a t e   	 	 	 	 	 	 d a t e ,  
 	 c m b C u r r E n r l   	 	 	 	 	 i n t e g e r ,  
 	 c m b V o l D e s k U s e r   	 	 	 	 	 i n t e g e r ,  
 	 c m b T r a c k i n g _ S t a t u s   	 	 	 	 i n t e g e r ,  
 	 t x t T r a c k i n g D a t e   	 	 	 	 d a t e ,  
 	 c m b E v e n t   	 	 	 	 	 	 i n t e g e r ,  
 	 c m b L i s t   	 	 	 	 	 	 i n t e g e r ,  
 	 c m b F o r m s t a c k Q u e s t i o n 1   	 	 	 i n t e g e r ,  
 	 c m b F o r m s t a c k R e s p 1   	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 c m b F o r m s t a c k Q u e s t i o n 2   	 	 	 i n t e g e r ,  
 	 c m b F o r m s t a c k R e s p 2   	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 c m b F o r m s t a c k Q u e s t i o n 3   	 	 	 i n t e g e r ,  
 	 c m b F o r m s t a c k R e s p 3   	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 c m b F o r m s t a c k Q u e s t i o n 4   	 	 	 i n t e g e r ,  
 	 c m b F o r m s t a c k R e s p 4   	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 c m b F o r m s t a c k Q u e s t i o n 5   	 	 	 i n t e g e r ,  
 	 c m b F o r m s t a c k R e s p 5   	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 A 8 _ S t a t u s   	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 A 1 9 _ S t a t u s   	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 t x t A p p F r o m   	 	 	 	 	 	 d a t e ,  
 	 t x t A p p T h r u   	 	 	 	 	 	 d a t e ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c m b C o n g 	 	 	 	 	 	 	 i n t e g e r ,  
 	 c h k A v a i l V o l 	 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ v o l   d e f a u l t   0 ,  
 	 c h k A v a i l V o l A n y t i m e 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ v o l _ a n y t i m e   d e f a u l t   0 ,  
 	 c h k A v a i l L T T V 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ l t t v   d e f a u l t   0 ,  
 	 c h k A v a i l C o n s u l t a n t 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ c o n s   d e f a u l t   0 ,  
 	 c h k A v a i l R e m o t e 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ r e m o t e   d e f a u l t   0 ,  
 	 c h k A v a i l C o m m u t e r 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ c o m m   d e f a u l t   0 ,  
 	 c h k A v a i l C o m m u t e r A s N e e d e d 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ c o m m _ a s _ n e e d   d e f a u l t   0 ,  
 	 t x t S T T V D a y s 	 	 	 	 	 	 i n t e g e r ,  
 	 t x t R e m o t e D a y s 	 	 	 	 	 i n t e g e r ,  
 	 t x t C o m m u t e D a y s 	 	 	 	 	 i n t e g e r ,  
 	 c h k S a f e t y V a l i d 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ s a f e t y _ v a l i d   d e f a u l t   0 ,  
 	 c m b A p p r o v a l L e v e l 	 	 	 	 i n t e g e r ,  
 	 c m b T r a i n i n g C o u r s e 	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
         t x t T r a i n i n g C o m p l e t e D a t e 	 	 	 d a t e ,  
         C u r r e n t E n r o l l m e n t   	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 P a s t E n r o l l m e n t   	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 P r i o r S i t e 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 P r i o r D a t e 	 	 	 	 	 	 d a t e ,  
 	 A p p T y p e 	 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 c m b B A _ E v e n t 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 c h k T r a i n i n g N o t C o m p l e t e 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ t r a i n _ n o t _ c o m p l e t e   d e f a u l t   0 ,  
 	 t x t D e p t S i t e 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 t x t D e p t N a m e 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 t x t D e p t D a t e 	 	 	 	 	 	 d a t e ,  
 	 c m b S k i l l _ Y r 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 c m b S k i l l _ Y r _ 2 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 c m b S k i l l _ Y r _ 3 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 t x t F u l l T e x t 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 t x t F u l l T e x t 2 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 t x t F u l l T e x t 3 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 c m b F u l l T e x t L o g i c 	 	 	 	 n v a r c h a r ( 1 0 ) ,  
 	 o p t g r p C u r r E n r l 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ o p t _ c u r r _ e n r l   d e f a u l t   1 ,  
 	 c m b W R K C r e w 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 c m b W R K R o l e 	 	 	 	 	 	 n v a r c h a r ( 2 5 5 ) ,  
 	 t x t C o n g D a t e 	 	 	 	 	 	 d a t e ,  
 	 c h k A v a i l M o n 	 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ m o n   d e f a u l t   0 ,  
 	 c h k A v a i l T u e 	 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ t u e   d e f a u l t   0 ,  
 	 c h k A v a i l W e d 	 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ w e d   d e f a u l t   0 ,  
 	 c h k A v a i l T h u 	 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ t h u   d e f a u l t   0 ,  
 	 c h k A v a i l F r i 	 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ f r i   d e f a u l t   0 ,  
 	 c h k A v a i l S a t 	 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ s a t   d e f a u l t   0 ,  
 	 c h k A v a i l S u n 	 	 	 	 	 	 b i t 	 	 	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s e a r c h _ s a v e _ a v a i l _ s u n   d e f a u l t   0 ,  
 	 c m b C o m p l e x 	 	 	 	 	 	 n v a r c h a r ( 3 ) ,  
 	 c o n s t r a i n t   v o l u n t e e r _ s e a r c h _ s a v e _ a k   u n i q u e   (   u s e r _ k e y ,   d e s c r i p t i o n   )   ) 	  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ s e a r c h _ s a v e   a d d   c o n s t r a i n t   v o l u n t e e r _ s e a r c h _ s a v e _ f k _ u s e r   f o r e i g n   k e y   (   u s e r _ k e y   )   r e f e r e n c e s   d b o . [ u s e r ] (   u s e r _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ S k i l l ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ S k i l l  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ S k i l l (  
 	 V o l u n t e e r _ S k i l l _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ s k i l l _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 S k i l l _ S p e c i a l i t y _ K e y   	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 S k i l l _ L e v e l _ K e y   	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 S o u r c e _ S y s t e m _ K e y   	 	 	 	 i n t e g e r 	 	 	 	 	 n o t   n u l l ,  
 	 S k i l l _ D e s c r i p t i o n   	 	 	 	 n v a r c h a r ( 4 0 0 0 ) ,  
 	 Y r s _ E x p   	 	 	 	 	 	 d e c i m a l ( 8 , 2 ) ,  
 	 P e r s o n a l _ N o t e s   	 	 	 	 	 n v a r c h a r ( m a x ) ,    
 	 O f f i c e _ N o t e s 	 	 	 	 	 n v a r c h a r ( m a x ) ,  
 	 O v s r _ A s s e s s m e n t _ N a m e 	   	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 O v s r _ A s s e s s m e n t _ S k i l l _ L e v e l _ K e y 	 i n t e g e r ,  
 	 O v s r _ A s s e s s m e n t _ N o t e s 	 	 	 n v a r c h a r ( m a x ) ,  
 	 O v s r _ A s s e s s m e n t _ D a t e   	 	 	 d a t e ,  
 	 S k i l l _ U p d a t e _ D a t e 	 	 	 	 d a t e ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s k i l l _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s k i l l _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ s k i l l _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 c o n s t r a i n t   v o l u n t e e r _ s k i l l _ a k   u n i q u e   (   v o l u n t e e r _ k e y ,   s k i l l _ s p e c i a l i t y _ k e y   )   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ s k i l l   a d d   c o n s t r a i n t   v o l u n t e e r _ s k i l l _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ s k i l l   a d d   c o n s t r a i n t   v o l u n t e e r _ s k i l l _ f k _ s k i l l _ s p e c i a l i t y   f o r e i g n   k e y   (   s k i l l _ s p e c i a l i t y _ k e y   )   r e f e r e n c e s   d b o . s k i l l _ s p e c i a l i t y (   s k i l l _ s p e c i a l i t y _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ s k i l l   a d d   c o n s t r a i n t   v o l u n t e e r _ s k i l l _ f k _ s k i l l _ l e v e l   f o r e i g n   k e y   (   s k i l l _ l e v e l _ k e y   )   r e f e r e n c e s   d b o . s k i l l _ l e v e l (   s k i l l _ l e v e l _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ s k i l l   a d d   c o n s t r a i n t   v o l u n t e e r _ s k i l l _ f k _ s o u r c e _ s y s t e m   f o r e i g n   k e y   (   s o u r c e _ s y s t e m _ k e y   )   r e f e r e n c e s   d b o . s o u r c e _ s y s t e m (   s o u r c e _ s y s t e m _ k e y   )  
 g o  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ s k i l l   a d d   c o n s t r a i n t   v o l u n t e e r _ s k i l l _ f k _ o v s r _ a s s e s s m e n t _ s k i l l _ l e v e l   f o r e i g n   k e y   (   o v s r _ a s s e s s m e n t _ s k i l l _ l e v e l _ k e y   )   r e f e r e n c e s   d b o . s k i l l _ l e v e l (   s k i l l _ l e v e l _ k e y   )  
 g o  
  
  
 i f   o b j e c t _ i d ( ' d b o . V o l u n t e e r _ T r a i n i n g ' ,   ' U ' )   i s   n o t   n u l l  
 	 d r o p   t a b l e   d b o . V o l u n t e e r _ T r a i n i n g  
 g o    
 c r e a t e   t a b l e   d b o . V o l u n t e e r _ T r a i n i n g (  
 	 V o l u n t e e r _ T r a i n i n g _ K e y   	 	 	 i n t e g e r   i d e n t i t y ( 1 , 1 )   	 n o t   n u l l   c o n s t r a i n t   v o l u n t e e r _ t r a i n i n g _ p k   p r i m a r y   k e y ,  
 	 V o l u n t e e r _ K e y   	 	 	 	 	 i n t e g e r   	 	 	 	 n o t   n u l l ,  
 	 V o l u n t e e r _ I D 	 	 	 	 	 b i g i n t ,  
 	 P e r s o n _ G U I D   	 	 	 	 	 u n i q u e i d e n t i f i e r   	 	 n o t   n u l l ,  
 	 C o u r s e _ N a m e   	 	 	 	 	 n v a r c h a r ( 3 0 0 ) 	 	 	 n o t   n u l l ,  
 	 P e r s o n _ E d u c a t i o n _ G U I D   	 	 	 u n i q u e i d e n t i f i e r , 	  
 	 P e r s o n _ E d u c a t i o n _ I D   	 	 	 i n t ,  
 	 C o u r s e _ D e s c   	 	 	 	 	 n v a r c h a r ( m a x ) ,  
 	 C o u r s e _ T y p e _ I D   	 	 	 	 	 i n t ,  
 	 C o u r s e _ T y p e   	 	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 C o u r s e _ T y p e _ D e s c   	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 C l a s s _ N u m b e r   	 	 	 	 	 n v a r c h a r ( 4 0 ) ,  
 	 C l a s s _ N a m e   	 	 	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 C l a s s _ C o m p l e t i o n _ N o t e s   	 	 	 n v a r c h a r ( 1 0 0 0 ) ,  
 	 C o u r s e _ O b j e c t i v e   	 	 	 	 n v a r c h a r ( 6 0 0 ) ,  
 	 S t u d e n t _ M e t _ O b j e c t i v e   	 	 	 b i t ,  
 	 A t t e n d a n c e _ S t a t u s   	 	 	 	 n v a r c h a r ( 2 0 0 ) ,  
 	 A s s i g n _ D a t e   	 	 	 	 	 d a t e t i m e , 	  
 	 S t a r t _ D a t e   	 	 	 	 	 	 d a t e t i m e  
 	 C o m p l e t e _ D a t e   	 	 	 	 	 d a t e ,  
 	 M o d i f i e d _ D a t e   	 	 	 	 	 d a t e t i m e ,  
 	 H o s t _ B r a n c h _ C o d e 	 	 	 	 n v a r c h a r ( 2 0 ) ,  
 	 A c t i v e _ F l a g   	 	 	 	 	 n v a r c h a r ( 1 )   	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ t r a i n i n g _ a c t i v e _ f l a g   d e f a u l t   ' Y ' ,  
 	 L o a d _ D a t e   	 	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ t r a i n i n g _ l o a d _ d a t e   d e f a u l t   g e t d a t e ( ) ,  
 	 U p d a t e _ D a t e   	 	 	 	 	 d a t e t i m e   	 	 	 	 n o t   n u l l   c o n s t r a i n t   d f _ v o l u n t e e r _ t r a i n i n g _ u p d a t e _ d a t e   d e f a u l t   g e t d a t e ( )   )  
 g o  
  
 a l t e r   t a b l e   d b o . v o l u n t e e r _ t r a i n i n g   a d d   c o n s t r a i n t   v o l u n t e e r _ t r a i n i n g _ f k _ v o l u n t e e r   f o r e i g n   k e y   (   v o l u n t e e r _ k e y   )   r e f e r e n c e s   d b o . v o l u n t e e r (   v o l u n t e e r _ k e y   )   o n   d e l e t e   c a s c a d e  
 g o  
 