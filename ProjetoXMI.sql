drop table if exists Stock ;
drop table if exists JogoVenda ;
drop table if exists VendaFormaDePagamento ;
drop table if exists Loja ;
drop table if exists Funcionario ;
drop table if exists Jogo ;
drop table if exists Genero ;
drop table if exists Fornecedor ;
drop table if exists ClienteComPerfil ;
drop table if exists Venda ;
drop table if exists Despesas ;
drop table if exists FormaDePagamento ;
drop table if exists Distrito ;
drop table if exists Cargo ;
 
create table Stock
(
   Loja_IdLoja_   Integer   not null,
   Jogo_IdJogo_   Integer   not null,
   Quantidade   Integer   null,
   DataRegisto   date   null,
 
   constraint PK_Stock primary key (Loja_IdLoja_, Jogo_IdJogo_)
);
 
create table JogoVenda
(
   Jogo_IdJogo_   Integer   not null,
   Venda_IdVenda_   Integer   not null,
 
   constraint PK_JogoVenda primary key (Jogo_IdJogo_, Venda_IdVenda_)
);
 
create table VendaFormaDePagamento
(
   Venda_IdVenda_   Integer   not null,
   FormaDePagamento_Sigla_   varchar(3)   not null,
 
   constraint PK_VendaFormaDePagamento primary key (Venda_IdVenda_, FormaDePagamento_Sigla_)
);
 
create table Loja
(
   Distrito_sigla   char(4)   not null,
   IdLoja   Integer   not null,
   Localidade   varchar(50)   null,
   Morada   varchar(100)   null,
   DataAbertura   date   null,
 
   constraint PK_Loja primary key (IdLoja)
);
 
create table Funcionario
(
   Loja_IdLoja   Integer   not null,
   Cargo_Sigla   varchar(3)   not null,
   DataDeIngressoCargo   date   null,
   DataDeFimCargo   date   null,
   IdFuncionario   Integer   not null,
   Nome   varchar(100)   null,
   Idade   Integer   null,
   Morada   varchar(100)   null,
   Telemovel   Integer   null,
   Mail   varchar(100)   null,
   Nif   Integer   null,
   DataDeIngresso   date   null,
   RegimeHorario   varchar(50)   null,
 
   constraint PK_Funcionario primary key (IdFuncionario)
);
 
create table Jogo
(
   Fornecedor_IdFornecedor   Integer   not null,
   IdJogo   Integer   not null,
   Nome   varchar(100)   null,
   Preco   double   null,
   DataLancamento   date   null,
   Gen1   varchar(3)   null,
   Gen2   varchar(3)   null,
 
   constraint PK_Jogo primary key (IdJogo)
);
 
create table Genero
(
   Sigla   varchar(3)   not null,
   genero   varchar(100)   null,
 
   constraint PK_Genero primary key (Sigla)
);
 
create table Fornecedor
(
   IdFornecedor   Integer   not null,
   Nome   varchar(100)   null,
   Representante   varchar(100)   null,
   RepresentanteContacto   varchar(50)   null,
 
   constraint PK_Fornecedor primary key (IdFornecedor)
);
 
create table ClienteComPerfil
(
   Loja_IdLoja   Integer   not null,
   IdCliente   Integer   not null,
   Nome   varchar(100)   null,
   Idade   Integer   null,
   Morada   varchar(100)   null,
   Telemovel   Integer   null,
   Mail   varchar(100)   null,
   Nif   Integer   null,
   dataDeCriacao   date   null,
 
   constraint PK_ClienteComPerfil primary key (IdCliente)
);
 
create table Venda
(
   Loja_IdLoja   Integer   not null,
   Funcionario_IdFuncionario   Integer   not null,
   ClienteComPerfil_IdCliente   Integer   not null,
   IdVenda   Integer   not null,
   HoraDaVenda   datetime   null,
 
   constraint PK_Venda primary key (IdVenda)
);
 
create table Despesas
(
   Loja_IdLoja   Integer   not null,
   Ano   Integer   null,
   Mes   Integer   null,
   Luz   double   null,
   Agua   double   null,
   Aluguer   double   null,
   OutrosGastos   double   null,
   Imprevistos   double   null,
   IdDespesa   Integer   not null,
 
   constraint PK_Despesas primary key (IdDespesa)
);
 
create table FormaDePagamento
(
   Sigla   varchar(3)   not null,
   formaDePagamento   varchar(50)   null,
 
   constraint PK_FormaDePagamento primary key (Sigla)
);
 
create table Distrito
(
   distrito   varchar(50)   null,
   sigla   char(4)   not null,
 
   constraint PK_Distrito primary key (sigla)
);
 
create table Cargo
(
   Sigla   varchar(3)   not null,
   DesignacaoCargo   varchar(50)   null,
   Ordenado   Integer   null,
 
   constraint PK_Cargo primary key (Sigla)
);
 
alter table Stock
   add constraint FK_Loja_Stock_Jogo_ foreign key (Loja_IdLoja_)
   references Loja(IdLoja)
   on delete cascade
   on update cascade
; 
alter table Stock
   add constraint FK_Jogo_Stock_Loja_ foreign key (Jogo_IdJogo_)
   references Jogo(IdJogo)
   on delete cascade
   on update cascade
;
 
alter table JogoVenda
   add constraint FK_Jogo_JogoVenda_Venda_ foreign key (Jogo_IdJogo_)
   references Jogo(IdJogo)
   on delete cascade
   on update cascade
; 
alter table JogoVenda
   add constraint FK_Venda_JogoVenda_Jogo_ foreign key (Venda_IdVenda_)
   references Venda(IdVenda)
   on delete cascade
   on update cascade
;
 
alter table VendaFormaDePagamento
   add constraint FK_Venda_VendaFormaDePagamento_FormaDePagamento_ foreign key (Venda_IdVenda_)
   references Venda(IdVenda)
   on delete cascade
   on update cascade
; 
alter table VendaFormaDePagamento
   add constraint FK_FormaDePagamento_VendaFormaDePagamento_Venda_ foreign key (FormaDePagamento_Sigla_)
   references FormaDePagamento(Sigla)
   on delete cascade
   on update cascade
;
 
alter table Loja
   add constraint FK_Loja_DistritoLoja_Distrito foreign key (Distrito_sigla)
   references Distrito(sigla)
   on delete restrict
   on update cascade
;
 
alter table Funcionario
   add constraint FK_Funcionario_LojaFuncionario_Loja foreign key (Loja_IdLoja)
   references Loja(IdLoja)
   on delete restrict
   on update cascade
; 
alter table Funcionario
   add constraint FK_Funcionario_PeriodoDoCargo_Cargo foreign key (Cargo_Sigla)
   references Cargo(Sigla)
   on delete restrict
   on update cascade
;
 
alter table Jogo
   add constraint FK_Jogo_FornecedorProduto_Fornecedor foreign key (Fornecedor_IdFornecedor)
   references Fornecedor(IdFornecedor)
   on delete restrict
   on update cascade
;
 
 
 
alter table ClienteComPerfil
   add constraint FK_ClienteComPerfil_LojaPerfilCliente_Loja foreign key (Loja_IdLoja)
   references Loja(IdLoja)
   on delete restrict
   on update cascade
;
 
alter table Venda
   add constraint FK_Venda_LojaVenda_Loja foreign key (Loja_IdLoja)
   references Loja(IdLoja)
   on delete restrict
   on update cascade
; 
alter table Venda
   add constraint FK_Venda_FuncionarioVenda_Funcionario foreign key (Funcionario_IdFuncionario)
   references Funcionario(IdFuncionario)
   on delete restrict
   on update cascade
; 
alter table Venda
   add constraint FK_Venda_VnedaClienteComPerfil_ClienteComPerfil foreign key (ClienteComPerfil_IdCliente)
   references ClienteComPerfil(IdCliente)
   on delete restrict
   on update cascade
;
 
alter table Despesas
   add constraint FK_Despesas_DespesasLoja_Loja foreign key (Loja_IdLoja)
   references Loja(IdLoja)
   on delete restrict
   on update cascade
;
 
 
 
 
