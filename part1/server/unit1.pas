unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms,lNet, Controls, Graphics, Dialogs, StdCtrls,
  lNetComponents;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    LTCP: TLTCPComponent;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LTCPDisconnect(aSocket: TLSocket);
    procedure LTCPError(const msg: string; aSocket: TLSocket);
    procedure LTCPReceive(aSocket: TLSocket);
  private

  public
      fnet:TLconnection;
  end;

var
  Form1: TForm1;

implementation
    uses
      lCommon;
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  fnet:=LTCP;
  LTCP.SocketNet:=LAF_INET;
end;

procedure TForm1.LTCPDisconnect(aSocket: TLSocket);
begin
  memo1.lines.add('disconnected ');
end;

procedure TForm1.LTCPError(const msg: string; aSocket: TLSocket);
begin
  memo1.lines.add('error : '+msg);
end;

procedure TForm1.LTCPReceive(aSocket: TLSocket);
var
  s:string;
begin
  aSocket.GetMessage(s);
  memo1.lines.add('client : ' + s);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if fnet.Listen(strtoint(edit1.Text))then
  memo1.Lines.add('listning....');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  fnet.SendMessage(edit2.text);
  memo1.Lines.add('server : '+ edit2.Text);
  edit2.Text:='';
end;

end.

