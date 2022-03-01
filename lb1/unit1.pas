unit Unit1;;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

// Базовый класс
type

  { TPerson }

  TPerson = class
    fName: string; // имя
    constructor Create(Name: string);
    function info: string; virtual;
  end;

  { TStudent }

  TStudent = class(TPerson)
    fGr: integer; // номер группы
    constructor Create(Name: string; gr: integer);
    function info: string; override;
    //function printName:String;
  end;

  // класс Преподаватель

  { TProf }

  TProf = class(TPerson)
    fDep: string; // название кафедры
    constructor Create(Name: string; dep: string);
    function info: string; override;
  end;

const
  SZL = 10; // размер списка

var
  Form1: TForm1;
  List: array[1..SZL] of TPerson;
  n: integer = 0; //количество людей в списке

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button2Click(Sender: TObject);
begin
  if n < SZL then
  begin
    // добавить объект в список
    n := n + 1;
    // создадим объект TStud
    if Radiobutton1.Checked then
      List[n] := TStudent.Create(Edit1.Text, StrToInt(Edit2.Text))
    else // создать объект TProf
      List[n] := TProf.Create(Edit1.Text, Edit2.Text);
    //очистить поля ввода
    Edit1.Text := '';
    Edit2.Text := '';
    Edit1.SetFocus; // курсор в поле Фамилия
  end
  else
    ShowMessage('Список заполнен!');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i, j: integer; // индекс
  st: string; // список
  tmp:TPerson;
  f1, f2:String;
  n1,n2:integer;
begin


  for i:=1 to n do
    for j:=1 to n-1 do
      begin
        f1 := list[j].fName; //Иванов
        f2 := list[j+1].fName; //Петров
                 //200    //185
        n1:=ord(f1[1]);
        n2:=ord(f2[1]);
        if n2>n1 then
        begin
          tmp:= list[j];    //  5  5 4
          list[j] := list[j+1]; //5 4 4
          list[j+1] := tmp; //4 5
        end;
      end;
  for i := 1 to SZL do
    if list[i] <> nil then st := st + list[i].info + #13;
       ShowMessage('Список' + #13 + st);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer; // индекс
  st: string; // список
begin
  for i := 1 to SZL do
    if list[i] <> nil then st := st + list[i].info + #13;
  ShowMessage('Список' + #13 + st);
end;



{ TProf }

constructor TProf.Create(Name: string; dep: string);
begin
  // вызвать конструктор базового класса
  inherited Create(Name);
  fDep := dep;
end;

function TProf.info: string;
begin
  Result := fname + ' каф.' + fDep;
end;

{ TStudent }

constructor TStudent.Create(Name: string; gr: integer);
begin
  // вызвать конструктор базового класса
  inherited Create(Name);
  fGr := gr;
end;

function TStudent.info: string;
begin
  Result := fname + ' rp.' + IntToStr(fGr);
end;

{ TPerson }

constructor TPerson.Create(Name: string);
begin
  fName := Name;
end;

function TPerson.info: string;
begin
  Result := fName;
end;

end.
