-- 사용자(회원) 정보를 저장할 테이블 --ok
CREATE TABLE mini_users(
	id VARCHAR2(100) PRIMARY KEY,
	pwd VARCHAR2(100) NOT NULL,
	email VARCHAR2(100),
	profile VARCHAR2(100), -- 프로필 이미지 경로를 저장할 칼럼
	regdate DATE -- 가입일
);


CREATE TABLE mini_board_cafe(
	num NUMBER PRIMARY KEY, --글번호
	writer VARCHAR2(100) NOT NULL, --작성자(로그인 된 아이디)
	title VARCHAR2(100) NOT NULL, --제목
	content CROB, --글 내용
	viewCount NUMBER, --조회수
	regdate DATE --글 작성일 
);

--게시글의 번호를 얻어낼 시퀀스 
CREATE SEQUENCE mini_board_cafe_seq;

--업로드된 파일의 정보를 저장할 테이블
CREATE TABLE mini_board_file(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100) NOT NULL,
	title VARCHAR2(100) NOT NULL,
	orgFileName VARCHAR2(100) NOT NULL, -- 원본 파일명
	saveFileName VARCHAR2(100) NOT NULL, -- 서버에 실제로 저장된 파일명
	fileSize NUMBER NOT NULL, -- 파일의 크기 
	regdate DATE
);

CREATE SEQUENCE mini_board_file_seq;

CREATE TABLE mini_board_gallery(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100),
	caption VARCHAR2(100),
	imagePath VARCHAR2(100),
	regdate DATE
);

CREATE SEQUENCE mini_board_gallery_seq;
