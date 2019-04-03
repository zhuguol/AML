create or replace view vi_aml_bs as
select SYS_GUID() as id,
--报文信息段
       substr(x.file_name,19,8)as bsrq,--报送日期
       to_char(x.crt_tm,'yyyymmdd')as dbrq,--打包日期
       t.brno,--机构号
       t.bsid as report_id,--可疑案件编号
       t.work_date,--工作日期
       t.report_type||'BS' as report_type,--报文类型
       d.ywtx as aacgrp,--业务条线
       p.A_XIBR2M,--所属分行
       t.IS_SUB_SUCCESS,--是否已成功上报
       t.REC_STATUS,--记录状态
       t.RPNM,--填报人     新增  20181122
       t.filler1 check_status,--抽样调查状态
       t.filler5 check_customer,--抽样调查员
       case when t.filler1 = 'Y' then t.lst_upd_tm end check_tm,--抽样调查时间
       t.Ricd,--报告机构编码             3号令新增  20181122
       t.RPNC,--上报网点代码             3号令新增  20181122
       t.FINM,--金融机构名称            （3号令不用了）
       t.FIRC,--金融机构所在地区代码    （3号令不用了）
       t.FICT,--金融机构代码类型        （3号令不用了）
       t.FICD,--金融机构代码            （3号令不用了）
       t.STCR,--可疑交易特征代码
       t.SSDG,--可疑程度                （3号令不用了）
       t.TKMS,--采取措施                （3号令不用了）
       t.SSDS,--可疑行为描述            （3号令不用了）
       t.LST_UPD_TLR,--最后更新人
       t.DETR,--可疑交易报告紧急程度            3号令新增  20181122
       t.TORP,--报送次数标志                    3号令新增  20181122
       t.DORP,--报送方向                        3号令新增  20181122
       t.ODRP,--其他报送方向                    3号令新增  20181122
       t.TPTR,--可疑交易报告触发点              3号令新增  20181122
       t.OTPR,--其他可疑交易报告触发点          3号令新增  20181122
       t.STCB as stcb1,
       t.stcb2 as stcb2,
       t.stcb3 as stcb3,--资金交易及客户行为情况          3号令新增  20181122
       t.AOSP as aosp1,
       t.aosp2 as aosp2,
       t.aosp3 as aosp3,--疑点分析                        3号令新增  20181122
       t.TOSC,--疑似涉罪类型                    3号令新增  20181122
       t.orxn,--初次报送的可疑交易报告报文名称
       t.mirs,--人工补正标识
--客户信息段
       d.SENM,--可疑主体姓名/名称
       d.SETP,--可疑主体身份证件/证明文件类型
       d.oitp,--其他身份证件/证明文件类型       3号令新增  20181122
       d.SEID,--可疑主体身份证件/证明文件号码
       d.CSNM,--客户号
       d.CTTP,--客户类型
       d.sctl,--可疑主体联系电话
       d.SEAR,--可疑主体住址/经营地址
       d.SEEI,--可疑主体其他联系方式
       d.STNT,--可疑主体国籍
       d.SEVC,--可疑主体职业（对私）或行业（对公）
       d.RGCP,--注册资金                             （3号令不用了）
       d.SRNM,--可疑主体法定代表人姓名
       d.SRIT,--可疑主体法定代表人身份证件类型
       d.ORIT,--可疑主体法定代表人其他身份证件/证明文件类型        3号令新增  20181122
       d.SRID,--可疑主体法定代表人身份证件号码
       d.SCNM,--可疑主体控股股东或实际控制人名称                   3号令新增  20181122
       d.SCIT,--可疑主体控股股东或实际控制人身份证件/证明文件类型  3号令新增  20181122
       d.OCIT,--可疑主体控股股东或实际控制人其他身份证件/证明文件  3号令新增  20181122
       d.SCID,--可疑主体控股股东或实际控制人身份证件/证明文件号码  3号令新增  20181122
--交易信息段
       s.FINC,--金融机构网点代码                 3号令新增  20181122
       s.RLFC,--金融机构与客户的关系             3号令新增  20181122
       s.CSNM as TCSNM,--客户号
       s.ctnm as tctnm,--客户名称/姓名
       s.citp as tcitp,--客户身份证件/证明文件类型
       s.AOITP as TAOITP,--客户其他身份证件/证明文件类型
       s.CTID as TCTID,--客户身份证件/证明文件号码
       s.TCNM as TTCNM,--交易对手姓名/名称
       s.TCIT as TTCIT,--交易对手身份证件/证明文件类型
       s.CATP,--客户账户类型
       s.CTAC,--客户账号
       s.OATM,--客户账户开立时间
       s.CATM,--客户账户销户时间
       s.CBCT,--客户银行卡类型                        3号令新增  20181122
       s.OCBT,--客户银行卡其他类型                    3号令新增  20181122
       s.CBCN,--客户银行卡号码                        3号令新增  20181122
       s.TBNM,--交易代办人姓名
       s.TBIT,--交易代办人身份证件/证明文件类型
       s.boitp,--交易代办人其他身份证件/证明文件类型  3号令新增  20181122
       s.TBID,--交易代办人身份证件/证明文件号码
       s.TBNT,--交易代办人国籍
       s.TSTM,--交易时间
       s.TRCD,--交易发生地
       s.TRCDSUFFIX,--交易发生地
       s.TICD,--业务标识号
       s.RPMT,--收付款方匹配号类型      3号令新增  20181122
       s.RPMN,--收付款方匹配号          3号令新增  20181122
       s.TSTP,--交易方式
       s.OCTT,--非柜台交易方式                       3号令新增  20181122
       s.OOCT,--其他非柜台交易方式                   3号令新增  20181122
       s.OCEC,--非柜台交易方式的设备代码             3号令新增  20181122
       s.BPTC,--银行与支付机构之间的业务交易编码     3号令新增  20181122
       s.TSCT,--涉外收支交易分类与代码
       s.TSDR,--资金收付标志
       s.CRSP,--资金来源和用途
       s.CRTP,--交易币种
       s.CRAT,--交易金额
       s.CFIN,--对方金融机构网点名称
       s.CFCT,--对方金融机构网点代码类型
       s.CFIC,--对方金融机构网点代码
       s.CFRC,--对方金融机构网点行政区划代码
       s.CFRCSUFFIX,--对方金融机构网点行政区划代码
       s.TCNM,--交易对手姓名/名称
       s.TCIT,--交易对手身份证件/证明文件类型
       s.coitp,--其他身份证件/证明文件类型       3号令新增  20181122
       s.TCID,--交易对手身份证件/证明文件号码
       s.TCAT,--交易对手账号类型
       s.TCAC,--交易对手账号
       s.ROTF1,--交易备注信息               3号令新增  20181122
       s.ROTF2--交易备注信息                3号令新增  20181122
  from (select * from aml_bs_upload union all select * from aml_bs_upload_his) t
  left join  (select * from aml_bs_cus_upload union all select * from aml_bs_cus_upload_his) d
    on t.report_id = d.report_id
   and t.work_date = d.work_date
  left join (select * from aml_bs_trans_upload union all select * from aml_bs_trans_upload_his) s
    on t.report_id = s.report_id
   and t.work_date = s.work_date
  left join AML_SSBRCPP p
    on t.ficd = p.XIBRNO
  left join aml_ssbrcpp p
    on t.ficd = p.xibrno
  left join aml_sub_file_info x
    on t.xmlnm = x.file_name
   and x.is_del is null;
----可疑查询导出视图 结束;
