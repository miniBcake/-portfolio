--뷰
--create user BUNGEOBBANG identified by 1234;

SELECT * FROM BB_VIEW_BOARD_JOIN;
SELECT * FROM BB_VIEW_PRODUCT_JOIN;

DROP VIEW BB_VIEW_BOARD_JOIN;
DROP VIEW BB_VIEW_PRODUCT_JOIN;

------------------------------------뷰
CREATE VIEW BB_VIEW_PRODUCT_JOIN AS
SELECT PRODUCT_NUM, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_PROFILE_WAY, bp.BOARD_NUM, bp.PRODUCT_CATEGORY_NUM, PRODUCT_CATEGORY_NAME, BOARD_TITLE, BOARD_CONTENT
FROM BB_PRODUCT bp 
	--카테고리 테이블
	JOIN BB_PRODUCT_CATEGORY bpc ON bp.PRODUCT_CATEGORY_NUM = bpc.PRODUCT_CATEGORY_NUM 
	--게시글 테이블 (상품 상세정보용)
	LEFT JOIN BB_BOARD bb ON bp.BOARD_NUM = bb.BOARD_NUM;
------------------------------------뷰
CREATE VIEW BB_VIEW_BOARD_JOIN AS 
SELECT bb.BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, BOARD_WRITE_DAY, BOARD_OPEN, BOARD_DELETE, 
	bm.MEMBER_NUM, MEMBER_NICKNAME, 
	NVL(bl2.LIKE_CNT, 0) AS LIKE_CNT, 
	bbc.CATEGORY_NUM, CATEGORY_NAME
FROM BB_BOARD bb 
	--멤버 테이블
	LEFT JOIN BB_MEMBER bm ON bb.MEMBER_NUM = bm.MEMBER_NUM 
	--좋아요 합계
	LEFT JOIN (SELECT BOARD_NUM, count(*) AS LIKE_CNT FROM BB_LIKE GROUP BY BOARD_NUM)bl2 ON bb.BOARD_NUM = bl2.BOARD_NUM
	--카테고리 테이블
	LEFT JOIN BB_BOARD_CATEGORY bbc ON bb.CATEGORY_NUM = bbc.CATEGORY_NUM;
------------------------------------