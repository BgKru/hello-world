CREATE TABLE public.OBJ (
	ID				int primary key not null,
	"OID"				int unique obj_oid_un not null, 
    OBJ_TYP     	varchar(5)not null,
    FUL_NAM         varchar(800) not null,
    CTX				JSON not null,	
    CRT_ON          timestamp with local time zone,          
    UPD_ON          timestamp with local time zone,
    constraint CK_OBJ_OBJ_TYP check (obj_typ in ('FL', 'ORG'))
    
);
create unique index OBJ_ID_OBJ_TYP on public.OBJ (ID, OBJ_TYP);
create unique index OBJ_OID_UN on public.OBJ ("OID");
-------------------------------------------------
CREATE TABLE public.ORG (
	id_obj          int primary key not null,
	sht_nam         varchar(500) NOT NULL,
	inn             varchar(256) not NULL,
    ogrn            varchar(256) not NULL,
    kpp             varchar(256) not NULL,
    kpp             varchar(1000),
	CRT_ON          timestamp with local time zone,          
    UPD_ON          timestamp with local time zone,
	r_pso           int,
	CONSTRAINT org_id_obj_fkey FOREIGN KEY (id_obj) REFERENCES public.obj(id),
	CONSTRAINT org_r_pso_fkey FOREIGN KEY (r_pso) REFERENCES public.pso(id_obj)
);
create unique index ORG_OGRN_UN on public.ORG (OGRN);
create index ORG_SHT_NAM_IDX on public.ORG (SHT_NAM);
-------------------------------------------------
CREATE TABLE public.PSO (
	ID_OBJ          int primary key not null,
	LST_NAM         varchar(256) NOT NULL,
	FST_NAM         varchar(256) not NULL,
    MID_NAM         varchar(256),
    BRD             date not NULL,
    GNR             char(1),
    SNILS           varchar(256),
	INN             varchar(256),
    R_CTZ_SHP       varchar(256),
    BRD_PLC         varchar(256),
	OGRNIP          varchar(256),
    R_ID_DOC        int,
    CONSTRAINT pso_obj_fk FOREIGN KEY (id_obj) REFERENCES public.obj(id) on delete cascade,
    CONSTRAINT pso_doc_fk FOREIGN KEY (r_id_doc) REFERENCES public.doc(id) on delete set null,
    constraint CK_PSO_GNR check (GNR in ('F', 'M'))
);
create index PSO_GNR on public.PSO (GNR);
create index PSO_OGRNIP on public.PSO (OGRNIP);
create unique index PSO_SNILS_ID on public.ORG (SNILS, ID_OBJ);
-------------------------------------------------
CREATE TABLE public.AUD_EVT (
	ID              int primary key not null,
	EVT_TYP         varchar(256) NOT NULL,
	R_OBJ           varchar(256) not NULL,
    MSG             varchar(256),
    CRT_ON          timestamp with local time zone,
    CONSTRAINT evt_obj_fk FOREIGN KEY (R_OBJ) REFERENCES public.obj(id)
);
create index AUD_EVT_R_OBJ on public.AUD_EVT (R_OBJ);
-------------------------------------------------
CREATE TABLE public.DOC (
	id              int primary key not null,
	doc_typ         varchar(256) NOT NULL,
    ser             varchar(256) not NULL,
    num             varchar(256) not NULL,
    iss_by          varchar(1000),
    iss_dat         date,
	iss_plc         char(3) not NULL,
    exp_dat         date,
    r_obj           int not NULL,
    dsc             varchar2(255),
	CRT_ON          timestamp with local time zone,          
    UPD_ON          timestamp with local time zone,
	doc_photo       varchar2(1000),
    CONSTRAINT doc_obj_fk FOREIGN KEY (r_obj) REFERENCES public.obj(id) on delete cascade,
);
create unique index DOC_PKX on public.DOC (ID);
create index DOC_SER_NUM_TYPE on public.DOC (SER,NUM,DOC_TYP);
create index DOC_SER_NUM_TYPE2 on public.DOC (NUM,SER,DOC_TYP);
create unique index ROBJ_DOCTYP_UNIQUE on public.DOC (R_OBJ,DOC_TYP);
-------------------------------------------------
CREATE TABLE public.STF (
	id              int primary key not null,
	pos             varchar(256),
    dpt             varchar(256),
    stu             char(1) not NULL,
    r_org           int not NULL,
    r_pso           int not NULL,
    CRT_ON          timestamp with local time zone,          
    UPD_ON          timestamp with local time zone,
	dsc             char(3) not NULL,
    chf             char(1) not NULL,
    constraint CK_STF_STU check (GNR in ('A', 'B'))
    constraint CK_STF_CHF check (GNR in ('Y', 'N'))
    CONSTRAINT stf_org_fk FOREIGN KEY (r_org) REFERENCES public.oorg(id_obj) on delete cascade,
    CONSTRAINT doc_pso_fk FOREIGN KEY (r_obj) REFERENCES public.pso(id_obj) on delete cascade,
);
create unique index STF_ORG_PSO on public.STF (R_PSO,R_ORG);
create index STF_PSO on public.STF (R_PSO);
create unique index STF_PKX on public.STF (ID);
-------------------------------------------------