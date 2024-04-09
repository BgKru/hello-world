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
CREATE TABLE public.org (
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