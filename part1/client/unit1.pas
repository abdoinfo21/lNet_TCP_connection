unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls,lNet, Graphics, Dialogs, StdCtrls,
  lNetComponents;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    TCP: TLTCPComponent;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TCPDisconnect(aSocket: TLSocket);
    procedure TCPError(const msg: string; aSocket: TLSocket);
    procedure TCPReceive(aSocket: TLSocket);
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
   fnet:=TCP;
   TCP.SocketNet:=LAF_INET;
end;

procedure TForm1.TCPDisconnect(aSocket: TLSocket);
begin
  aSocket:=nil;
  memo1.Lines.add('disconnct');
end;

procedure TForm1.TCPError(const msg: string; aSocket: TLSocket);
begin
  aSocket:=nil;
 memo1.Lines.add('error '+ msg);
end;

procedure TForm1.TCPReceive(aSocket: TLSocket);
var
   s:string;
begin
  aSocket.GetMessage(s);
  memo1.Lines.add('server : '+ s);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  fnet.Connect(edit2.text,strtoint(edit3.Text));
  memo1.Lines.add('connected');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  fnet.SendMessage(edit1.text);
  memo1.Lines.add('client : ' + edit1.text);
  edit1.text:='';
end;

end.

