unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FWPopupPanel, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    FWPopupPanel1: TFWPopupPanel;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TrackBar1: TTrackBar;
    ProgressBar1: TProgressBar;
    MonthCalendar1: TMonthCalendar;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  FWPopupPanel1.Popup(Button1.ClientToScreen(Point(0, Button1.Height)));
end;

end.
