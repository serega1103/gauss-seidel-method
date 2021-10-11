unit gauss_seidel_method;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Samples.Spin, MAth, Buttons;

type
  Matrix = array of array of Real;
  Vector = array of Real;
  TMainForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edEpsilon: TEdit;
    edN: TSpinEdit;
    OutputResult: TMemo;
    Bd: TStringGrid;
    Ad: TStringGrid;
    Calculate: TButton;
    ClearResultAndMatrix: TButton;

    procedure CalculateClick(Sender: TObject);
    procedure edNChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearResultAndMatrixClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

// ������� ����������� ����������
procedure CheckConds(var result: Boolean; var X, X1: vector; n: Byte; eps: Real);
var
  l: Byte;
  mm: Real;
begin
  mm := abs(X1[1] - X[1]);
  for l := 2 to n+1 do
    if mm < abs(X1[l] - X[l]) then mm := abs(X1[l] - X[l]);
  if  mm < eps then result := true else result := false;
end;

// ���������� ���������� �������
procedure CalculateNextX(var A: Matrix; var B, X: Vector; n: Byte);
var
  l, m: Byte;
  zz: real;
begin
  for l := 1 to n do
  begin
    zz := (B[l] / A[l, l]);
    for m := 1 to n do
    begin
      if m = l then continue;
      zz := zz - (A[l, m] * X[m] / A[l, l])
    end;
    X[l] := zz;
  end;
end;

// ������������� ������� A
procedure TMatrixA(var A, A1: Matrix; n: Byte);
var
  i, j: Byte;
  tt: real;
begin
  A1 := A;
  for i := 1 to n do
  begin
    for j := i to n do
    begin
      tt := A1[i, j];
      A1[i, j] := A1[j, i];
      A1[j, i] := tt;
    end;
  end;
end;

// ����������� ��������: A'=(A^t)*A
procedure CalcA(var A2: Matrix; A,A1: Matrix; n: Byte);
var
  i, j, k: Byte;
  tt: real;
begin
  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      tt := 0;
      for k := 1 to n do
        tt := tt + A1[i, k] * A[k, j];
      A2[i, j] := tt;
    end;
  end;
end;

// ����������� ��������: B'=(A^t)*b
procedure CalcB(var B, B1: vector; A1:matrix; n: Byte);
var
  i, j: Byte;
  tt: real;
begin
  for i := 1 to n do
    begin
      tt := 0;
      for j := 1 to n do
        tt := tt + A1[i, j] * B[j];
      B1[i] := tt;
    end;
end;

// �������� �� ���������� ������� ����� � ������� �������������
procedure CheckNullRows(n: byte; A3: Matrix; var row:boolean);
var
  i, j, k: byte;
begin
 row:=false;
 for i := 1 to n do
  begin
    k:=0;
    for j := 1 to n do
    begin
      if A3[i,j]=0 then k:=k+1;
    end;
    if k=n then
    begin
     row:=true;
    end;
  end;
end;

// �������� �� ���������� ������� �������� � ������� �������������
procedure CheckNullCols(n: byte; A3: Matrix; var col:boolean);
var
  i, j, k: byte;
begin
col:=false;
for j := 1 to n do
  begin
    k:=0;
    for i := 1 to n do
    begin
      if A3[i,j]=0 then k:=k+1;
    end;
    if k=n then
    begin
      col:=true;
    end;
  end;
end;

// �������� �� ���������� ������� �������� � ��������� �������
procedure CheckNullVector(n: byte; B: vector; var vec:boolean);
var
  i, k: byte;
begin
   k:=0;
   for i := 1 to n do
    begin
      if B[i]=0 then k:=k+1;
    end;
    if k=n then
    begin
      vec:=true;
    end;
end;

// ������ ������ ������ �� ������ � ������ ��������� ���������
procedure ReplaceNullRows(n: byte; var A3: matrix);
var
  i, j: byte;
  ss: real;
begin
 if A3[1, 1] = 0 then
    for j := 2 to n do
        if A3[1, j] <> 0 then
        begin
          for i:=1 to n do
             begin
             ss:=A3[1,i];
             A3[1,i]:=A3[j,i];
             A3[j,i]:=ss;
             end;
          Break
        end;
end;

// �������������� ������� ������������� � ������������ ����
procedure TriangleMatrixForm (n: byte; var A3: matrix);
var
  i, j, k: byte;
begin
for i := 1 to n do
 begin
 for j := i+1 to n do
      if A3[j, i] <> 0 then
      begin
        for k := i+1 to n do
          A3[j, k] := A3[j, k] - A3[i, k] * A3[j, i] / A3[i, i];
        A3[j, i] := 0
      end;
 end;
end;

// ���������� ������������ �������
procedure CalculateDeterminant (n: byte; A3: matrix; var det:real);
var
  i: byte;
begin
  det:=1;
  for i := 1 to n do
    det := det * A3[i, i];
end;

// ������� ����
procedure TMainForm.CalculateClick(Sender: TObject);
var
  i, j, n, k: Byte;
  eps, det: Real;
  A, A1, A2, A3: Matrix;
  B, B1, X, X1: vector;
  result, col, row, vec: Boolean;
begin
  try
    n := StrToInt(edN.Text);
    eps := StrToFloat(edEpsilon.Text);
    SetLength(A, n + 1, n + 1);
    SetLength(A1, n + 1, n + 1);
    SetLength(A2, n + 1, n + 1);
    SetLength(A3, n + 1, n + 1);
    SetLength(B, n + 1);
    SetLength(B1, n + 1);
    for i := 1 to n do
    begin
      for j := 1 to n do
      begin
        A[i, j] := StrToFloat(Ad.Cells[j, i]);
      end;
      B[i] := StrToFloat(Bd.Cells[1, i]);
    end;
    A3:=A;
    CheckNullRows(n, A3, row);
    if row=true then
    begin
      MessageDlg('���� ���� �� ����� �������, ���� ����� �� ������������ ���������!', mtInformation, [mbOK], 0);
      exit
    end;
    CheckNullCols(n, A3, col);
    if col=true then
    begin
      MessageDlg('���� ���� �� ����� �������, ���� ����� �� ������������ ���������!', mtInformation, [mbOK], 0);
      exit
    end;
    CheckNullVector(n, B, vec);
    if vec=true then
    begin
      MessageDlg('���� ���� �� ����� �������, ���� ����� �� ������������ ���������!', mtInformation, [mbOK], 0);
      exit
    end;
    ReplaceNullRows(n, A3);
    TriangleMatrixForm (n, A3); // ���������� ������� �3 � ������������ ����
    CalculateDeterminant (n, A3, det);
    if det=0 then
    begin
      MessageDlg('���� ���� �� ����� �������, ���� ����� �� ������������ ���������!', mtInformation, [mbOK], 0);
      exit
    end;
    for i := 1 to n do
    begin
      for j := 1 to n do
      begin
        A[i, j] := StrToFloat(Ad.Cells[j, i]);
      end;
      B[i] := StrToFloat(Bd.Cells[1, i]);
    end;
    TMatrixA(A, A1, n);  // ���������������� �������.
    CalcA(A2, A, A1, n); // ����������� ��������: A'=(A^t)*A.
    CalcB(B, B1, A1, n); // ����������� ��������: B'=(A^t)*b.
    A := A2;
    B := B1;
    SetLength(X, n + 1);
    SetLength(X1, n + 1);
    for i := 1 to n do
      X[i] := 0;     //��������� ������������ ��������
    repeat
      X1 := X;
      CalculateNextX(A, B, X, n); //������� X
      CheckConds(result, X, X1, n, eps);
    until result; //����������� ������ ��������

    OutputResult.Lines.Add('��������� �������� ������:');
    for j := 1 to n do
    begin
      OutputResult.Lines.Add('�������� ��������� ������������ ��������������� ���������� �� ' + IntToStr(j) + '-�� ����� ');
      for i := 1 to n do
        OutputResult.Lines.Add('c[' + IntToStr(i) + ']=' + Ad.Cells[i, j]);
    end;
    for i := 1 to n do
    begin
      OutputResult.Lines.Add('��������� ������ ��������������� ���������� ��� ' + IntToStr(i) + '-�� �����:');
      OutputResult.Lines.Add('D/L[' + IntToStr(i) + ']=' + Bd.Cells[1,i]);
    end;

  OutputResult.Lines.Add('���������� �������� ������������ �������� � ��������:');
    for i := n downto 1 do
    begin
      k:=k+1;
      OutputResult.Lines.Add('c[' + IntToStr(k) + ']=' + FloatToStr(X[i]));
    end;
    ClearResultAndMatrix.Enabled := true;

  except
    on EConvertError do MessageDlg('������ ������� �����������!', mtError, [mbOK], 0);
  end;

  A := nil;
  A1 := nil;
  A2 := nil;
  B := nil;
  B1 := nil;
  X := nil;
  X1 := nil;

end;

// ��������� ����������� ������� � ���������� �������
procedure TMainForm.edNChange(Sender: TObject);
var
  i, z: Byte;
begin
  z := StrToInt(edN.Text) + 1;  // ����������� �������
  AD.RowCount := z;
  AD.ColCount := z;
  Bd.RowCount := z;
  for i := 1 to z do
  begin
    AD.Cells[0, i] := IntToStr(i);
    AD.Cells[i, 0] := IntToStr(i);
    Bd.Cells[0, i] := IntToStr(i);
  end;
end;

//�������� �����
procedure TMainForm.FormCreate(Sender: TObject);
var
  i, z: byte;
begin
  OutputResult.Lines.Clear;
  z := StrToInt(edN.Text);
  AD.Cells[0, 0] := 'A';
  Bd.Cells[0, 0] := 'B';
  Bd.Cells[1, 0] := '1';
  for i := 1 to z do
  begin
    AD.Cells[0, i] := IntToStr(i);
    AD.Cells[i, 0] := IntToStr(i);
    Bd.Cells[0, i] := IntToStr(i);
  end;
end;

//������� ������ � ���� ������
procedure TMainForm.ClearResultAndMatrixClick(Sender: TObject);
var
  i, j, z: byte;
begin
  OutputResult.Lines.Clear;

  z := StrToInt(edN.Text);
  begin
    with Ad do
      for i := 1 to z do   // ��������� ����� �� �������
        for j := 1 to z do   // ��������� �������� �� �������
          Cells[j, i] := '';
  end;

  with Bd do
    for i := 1 to z do   // ��������� ����� �� �������
      for j := 1 to z do   // ��������� �������� �� �������
        Cells[j, i] := '';

  ClearResultAndMatrix.Enabled := False;
end;

end.
