////////////////////////////////////////////////////////////////////////////////
//
//  ****************************************************************************
//  * Unit Name : FWPopupPanel
//  * Purpose   : Класс позволяющий создать составное PopUpMenu
//  * Author    : Александр (Rouse_) Багель
//  * Copyright : © Fangorn Wizards Lab 1998 - 2010.
//  * Version   : 1.00
//  * Home Page : http://rouse.drkb.ru
//  ****************************************************************************
//


unit FWPopupPanel;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Graphics,
  Forms;

type
  TOnBeforeHideEvent = procedure(Sender: TObject; var Accept: Boolean) of object;

  TFWCustomPopupPanel = class(TCustomControl)
  private
    FChild: TControl;
    FRootPopUp: TCustomForm;
    FHide: TOnBeforeHideEvent;
    FBorder: Boolean;
  protected
    procedure Paint; override;
    procedure DoHide(Sender: TObject; var Accept: Boolean);
    property OnBeforeHide: TOnBeforeHideEvent read FHide write FHide;
    property DrawBorder: Boolean read FBorder write FBorder default True;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Popup(P: TPoint);
    procedure Hide;
  end;

  TFWPopupPanel = class(TFWCustomPopupPanel)
  published
    property DrawBorder;
    property OnBeforeHide;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Fangorn Wizards Lab', [TFWPopupPanel]);
end;

type
  TRootFWPopUpPanel = class(TForm)
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    FOnHide: TOnBeforeHideEvent;
    FNeedBorder: Boolean;
    procedure NotifyHide(var Accept: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMActivateApp(var Message: TWMActivateApp); message WM_ACTIVATEAPP;
  public
    PreviosParent: TWinControl;
    PreviosParentHandle: THandle;
    property OnHide: TOnBeforeHideEvent read FOnHide write FOnHide;
    constructor Create(NeedBorder: Boolean); reintroduce;
  end;

constructor TRootFWPopUpPanel.Create(NeedBorder: Boolean);
begin
  FNeedBorder := NeedBorder;
  inherited CreateNew(nil, 0);
  BorderStyle := bsNone;
  OnDeactivate := FormDeactivate;
  OnKeyPress := FormKeyPress;
  OnActivate := FormActivate;
end;

procedure TRootFWPopUpPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if FNeedBorder then
      Style := Style or WS_BORDER
    else
      Style := Style and not WS_BORDER;
    WindowClass.Style := CS_SAVEBITS or CS_DROPSHADOW;
  end;
end;

procedure TRootFWPopUpPanel.NotifyHide(var Accept: Boolean);
begin
  if Assigned(FOnHide) then
    FOnHide(Self, Accept);
end;

procedure TRootFWPopUpPanel.FormActivate(Sender: TObject);
begin
   SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_DEFERERASE)
end;

procedure TRootFWPopUpPanel.FormDeactivate(Sender: TObject);
var
  ActiveControl: TWinControl;
  I: Integer;
  Accept: Boolean;
begin
  Accept := True;
  ActiveControl := FindControl(GetActiveWindow);
  if ActiveControl = nil then
    NotifyHide(Accept);
  if ActiveControl = Self then Exit;
  for I := 0 to ControlCount - 1 do
    if Controls[I] = ActiveControl then
      Exit;
  NotifyHide(Accept);
  if not Accept then
  begin
    SetFocus;
    ActiveControl := FindControl(GetFocus);
    if ActiveControl <> nil then
      ActiveControl.SetFocus;
  end;
end;

procedure TRootFWPopUpPanel.FormKeyPress(Sender: TObject; var Key: Char);
var
  Accept: Boolean;
begin
  if Byte(Key) = VK_ESCAPE then
    NotifyHide(Accept);
end;

procedure TRootFWPopUpPanel.WMActivateApp(var Message: TWMActivateApp);
var
  Accept: Boolean;
begin
  inherited;
  if not Message.Active then
    NotifyHide(Accept);
end;

{ TFWCustomPopupPanel }

constructor TFWCustomPopupPanel.Create(AOwner: TComponent);
begin
  inherited;
  FBorder := True;
  TabStop := True;
  Visible := csDesigning in ComponentState;
  if not Visible then
  begin
    Left := 0;
    Top := 0;
  end;
  DoubleBuffered := True;
  Width := 100;
  Height := 100;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents, csOpaque,
    csDoubleClicks, csNeedsBorderPaint];
end;

procedure TFWCustomPopupPanel.DoHide(Sender: TObject;
  var Accept: Boolean);
begin
  if Assigned(FHide) then
    FHide(Self, Accept);
  if not Accept then Exit;
  Visible := False;
  Parent := TRootFWPopUpPanel(FRootPopUp).PreviosParent;
  Windows.SetParent(Handle, TRootFWPopUpPanel(FRootPopUp).PreviosParentHandle);
  FRootPopUp.Hide;
  FRootPopUp.Release;
end;

procedure TFWCustomPopupPanel.Hide;
var
  Accept: Boolean;
begin
  DoHide(FRootPopUp, Accept);
end;

procedure TFWCustomPopupPanel.Paint;
const
  HintMessage = 'Place control here';
var
  R: TRect;
  TW, TH: Integer;
begin
  inherited;
  if csDesigning in ComponentState then
  begin
    R := GetClientRect;
    Canvas.Brush.Color := clInactiveBorder;
    Canvas.FillRect(R);
    Canvas.Pen.Style := psDash;
    Canvas.Pen.Color := clBlack;
    Canvas.Rectangle(R);
    TW := Canvas.TextWidth(HintMessage);
    TH := Canvas.TextHeight(HintMessage);
    Canvas.TextOut((R.Right - TW) shr 1, (R.Bottom - TH) shr 1, HintMessage);
  end;
end;

procedure TFWCustomPopupPanel.Popup(P: TPoint);
begin
  FRootPopUp := TRootFWPopUpPanel.Create(DrawBorder);
  TRootFWPopUpPanel(FRootPopUp).PreviosParentHandle := Windows.GetParent(Handle);
  TRootFWPopUpPanel(FRootPopUp).PreviosParent := Parent;
  Parent := FRootPopUp;
  Windows.SetParent(Handle, FRootPopUp.Handle);
  Left := 0;
  Top := 0;
  Visible := True;
  FRootPopUp.SetBounds(P.X, P.Y, Width, Height);
  TRootFWPopUpPanel(FRootPopUp).OnHide := DoHide;
  FRootPopUp.Show;
  FRootPopUp.SetFocus;
end;

end.
