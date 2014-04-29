(*
  Copyright 2014 Ezequiel Juliano M�ller | Microsys Sistemas Ltda

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*)

unit Main.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Connection.FireDAC;

type

  TMainView = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

uses
  Country.Model, Country.Controller, Country.View, Province.Model, Province.Controller,
  SQLBuilder4D, Dm.Models;

{$R *.dfm}


procedure TMainView.Button1Click(Sender: TObject);
var
  vCountryModel: TCountryModel;
  vCountryView: TCountryView;
begin
  vCountryModel := TCountryModel.Create(nil, TCountryController, ConnectionFireDAC.GetDatabase);
  vCountryView := TCountryView.Create(nil);
  try
    vCountryView.DsCountry.DataSet := vCountryModel.GetController<TCountryController>.GetDataSet;

    vCountryModel.GetController<TCountryController>.GetDataSet.Open();

    vCountryView.ShowModal;
  finally
    FreeAndNil(vCountryModel);
    FreeAndNil(vCountryView);
  end;
end;

procedure TMainView.Button2Click(Sender: TObject);
var
  vCountryModel: TCountryModel;
  vCountryView: TCountryView;
  vCountryController: TCountryController;
begin
  vCountryController := TCountryController.Create(ConnectionFireDAC.GetDatabase);
  vCountryModel := TCountryModel.Create(nil, vCountryController);
  vCountryView := TCountryView.Create(nil);
  try
    vCountryView.DsCountry.DataSet := vCountryModel.GetController<TCountryController>.GetDataSet;

    vCountryModel.GetController<TCountryController>.GetDataSet.Open();

    vCountryView.ShowModal;
  finally
    FreeAndNil(vCountryModel);
    FreeAndNil(vCountryView);
    FreeAndNil(vCountryController);
  end;
end;

procedure TMainView.Button3Click(Sender: TObject);
var
  vCountryModel: TCountryModel;
begin
  vCountryModel := TCountryModel.Create(nil, TCountryController, ConnectionFireDAC.GetDatabase);
  try
    vCountryModel.DataSet.Open();
    vCountryModel.DataSet.Insert;
    vCountryModel.DataSetCTY_CODE.AsInteger := Random(10000);
    vCountryModel.DataSetCTY_NAME.AsString := 'Country ' + vCountryModel.DataSetCTY_CODE.AsString;
    vCountryModel.DataSet.Post;

    vCountryModel.DataSet.Insert;
    vCountryModel.DataSetCTY_CODE.AsInteger := 0;
    vCountryModel.DataSetCTY_NAME.AsString := 'Country';
    vCountryModel.GetController<TCountryController>.ValidateFields();
    vCountryModel.DataSet.Post;
  finally
    FreeAndNil(vCountryModel);
  end;
end;

procedure TMainView.Button4Click(Sender: TObject);
var
  vCountryModel: TCountryModel;
  vProvinceModel: TProvinceModel;
begin
  vCountryModel := TCountryModel.Create(nil, TCountryController, ConnectionFireDAC.GetDatabase);
  vProvinceModel := TProvinceModel.Create(nil, TProvinceController, ConnectionFireDAC.GetDatabase);
  try
    vProvinceModel.DataSet.Open();

    vProvinceModel.DataSet.Insert;
    vProvinceModel.DataSetPRO_CODE.AsInteger := Random(10000);
    vProvinceModel.DataSetPRO_NAME.AsString := 'Province ' + vProvinceModel.DataSetPRO_CODE.AsString;

    vCountryModel.GetController<TCountryController>.SQLBuild(TSQLBuilder.Where('CTY_CODE').IsNotNull);
    vProvinceModel.DataSetCTY_CODE.AsInteger := vCountryModel.DataSetCTY_CODE.AsInteger;

    vProvinceModel.DataSet.Post;
  finally
    FreeAndNil(vCountryModel);
    FreeAndNil(vProvinceModel);
  end;
end;

procedure TMainView.Button5Click(Sender: TObject);
var
  vModels: TDmModels;
  vCountryController: TCountryController;
  vProvinceController: TProvinceController;
begin
  vModels := TDmModels.Create(nil);
  vCountryController := TCountryController.Create(ConnectionFireDAC.GetDatabase, vModels.DtsCountry);
  vProvinceController := TProvinceController.Create(ConnectionFireDAC.GetDatabase, vModels.DtsProvince);
  try
    vProvinceController.GetDataSet.Open();

    vProvinceController.GetDataSet.Insert;
    vProvinceController.GetDataSet.FieldByName('PRO_CODE').AsInteger := Random(10000);
    vProvinceController.GetDataSet.FieldByName('PRO_NAME').AsString := 'Province ' + vProvinceController.GetDataSet.FieldByName('PRO_CODE').AsString;

    vCountryController.SQLBuild(TSQLBuilder.Where('CTY_CODE').IsNotNull);
    vProvinceController.GetDataSet.FieldByName('CTY_CODE').AsInteger := vCountryController.GetDataSet.FieldByName('CTY_CODE').AsInteger;

    vProvinceController.GetDataSet.Post;
  finally
    FreeAndNil(vCountryController);
    FreeAndNil(vProvinceController);
    FreeAndNil(vModels);
  end;
end;

end.