﻿Add-Type -AssemblyName "PresentationCore", "PresentationFramework", "WindowsBase"

[xml]$xamlMarkup = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"        
        Title="Win10 Setup Script" Height="800" Width="800" FontSize="16" TextOptions.TextFormattingMode="Display" 
        ShowInTaskbar="False" WindowStartupLocation="CenterScreen" SnapsToDevicePixels="True">
    <Window.Resources>

        <!--#region Brushes -->

        <SolidColorBrush x:Key="RadioButton.Static.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.Static.Border" Color="#FF333333"/>
        <SolidColorBrush x:Key="RadioButton.Static.Glyph" Color="#FF333333"/>

        <SolidColorBrush x:Key="RadioButton.MouseOver.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.Border" Color="#FF000000"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.Glyph" Color="#FF000000"/>

        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Background" Color="#FF4C91C8"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Border" Color="#FF4C91C8"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Glyph" Color="#FFFFFFFF"/>

        <SolidColorBrush x:Key="RadioButton.Disabled.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.Border" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.Glyph" Color="#FF999999"/>

        <SolidColorBrush x:Key="RadioButton.Disabled.On.Background" Color="#FFCCCCCC"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.On.Border" Color="#FFCCCCCC"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.On.Glyph" Color="#FFA3A3A3"/>

        <SolidColorBrush x:Key="RadioButton.Pressed.Background" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Pressed.Border" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Pressed.Glyph" Color="#FFFFFFFF"/>

        <SolidColorBrush x:Key="RadioButton.Checked.Background" Color="#FF0063B1"/>
        <SolidColorBrush x:Key="RadioButton.Checked.Border" Color="#FF0063B1"/>
        <SolidColorBrush x:Key="RadioButton.Checked.Glyph" Color="#FFFFFFFF"/>

        <!--#endregion-->

        <Style x:Key="ToggleSwitchTopStyle" TargetType="{x:Type ToggleButton}">
            <Setter Property="Background" Value="{StaticResource RadioButton.Static.Background}"/>
            <Setter Property="BorderBrush" Value="{StaticResource RadioButton.Static.Border}"/>
            <Setter Property="Foreground" Value="{DynamicResource {x:Static SystemColors.ControlTextBrushKey}}"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="SnapsToDevicePixels" Value="True"/>
            <Setter Property="FocusVisualStyle" Value="{x:Null}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ToggleButton}">
                        <Grid x:Name="templateRoot" 
							  Background="Transparent" 
							  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}">
                            <VisualStateManager.VisualStateGroups>
                                <VisualStateGroup x:Name="CommonStates">
                                    <VisualState x:Name="Normal"/>
                                    <VisualState x:Name="MouseOver">
                                        <Storyboard>
                                            <DoubleAnimation To="0" Duration="0:0:0.2" Storyboard.TargetName="normalBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0:0:0.2" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Pressed">
                                        <Storyboard>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="pressedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Pressed.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Disabled">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="CheckStates">
                                    <VisualState x:Name="Unchecked"/>
                                    <VisualState x:Name="Checked">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Static.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimationUsingKeyFrames Duration="0:0:0.5" Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[3].(TranslateTransform.X)" Storyboard.TargetName="optionMark">
                                                <EasingDoubleKeyFrame KeyTime="0" Value="12"/>
                                            </DoubleAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Checked.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Indeterminate"/>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="FocusStates">
                                    <VisualState x:Name="Unfocused"/>
                                    <VisualState x:Name="Focused"/>
                                </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Grid.RowDefinitions>
                                <RowDefinition />
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>
                            <ContentPresenter x:Name="contentPresenter" 
											  Focusable="False" RecognizesAccessKey="True" 
											  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" 
											  Margin="{TemplateBinding Padding}" 
											  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" 
											  VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                            <Grid x:Name="markGrid" Grid.Row="1" Margin="0 8 0 2" Width="44" Height="20"
								  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}">
                                <Border x:Name="normalBorder" Opacity="1" BorderThickness="2" CornerRadius="10"
										BorderBrush="{TemplateBinding BorderBrush}" Background="{StaticResource RadioButton.Static.Background}"/>
                                <Border x:Name="checkedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource  RadioButton.Checked.Border}" Background="{StaticResource RadioButton.Checked.Background}"/>
                                <Border x:Name="hoverBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.MouseOver.Border}" Background="{StaticResource RadioButton.MouseOver.Background}"/>
                                <Border x:Name="pressedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Pressed.Border}" Background="{StaticResource RadioButton.Pressed.Background}"/>
                                <Border x:Name="disabledBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Disabled.Border}" Background="{StaticResource RadioButton.Disabled.Background}"/>
                                <Ellipse x:Name="optionMark"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Static.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="-12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                                <Ellipse x:Name="optionMarkOn" Opacity="0"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Checked.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                            </Grid>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="ToggleSwitchLeftStyle" TargetType="{x:Type ToggleButton}">
            <Setter Property="Background" Value="{StaticResource RadioButton.Static.Background}"/>
            <Setter Property="BorderBrush" Value="{StaticResource RadioButton.Static.Border}"/>
            <Setter Property="Foreground" Value="{DynamicResource {x:Static SystemColors.ControlTextBrushKey}}"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="SnapsToDevicePixels" Value="True"/>
            <Setter Property="FocusVisualStyle" Value="{x:Null}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ToggleButton}">
                        <Grid x:Name="templateRoot" 
							  Background="Transparent" 
							  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}">
                            <VisualStateManager.VisualStateGroups>
                                <VisualStateGroup x:Name="CommonStates">
                                    <VisualState x:Name="Normal"/>
                                    <VisualState x:Name="MouseOver">
                                        <Storyboard>
                                            <DoubleAnimation To="0" Duration="0:0:0.2" Storyboard.TargetName="normalBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0:0:0.2" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Pressed">
                                        <Storyboard>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="pressedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Pressed.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Disabled">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="CheckStates">
                                    <VisualState x:Name="Unchecked"/>
                                    <VisualState x:Name="Checked">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Static.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimationUsingKeyFrames Duration="0:0:0.5" Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[3].(TranslateTransform.X)" Storyboard.TargetName="optionMark">
                                                <EasingDoubleKeyFrame KeyTime="0" Value="12"/>
                                            </DoubleAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Checked.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Indeterminate"/>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="FocusStates">
                                    <VisualState x:Name="Unfocused"/>
                                    <VisualState x:Name="Focused"/>
                                </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition />
                                <ColumnDefinition Width="Auto"/>
                            </Grid.ColumnDefinitions>
                            <ContentPresenter x:Name="contentPresenter" 
											  Focusable="False" RecognizesAccessKey="True" 
											  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" 
											  Margin="{TemplateBinding Padding}" 
											  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" 
											  VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                            <Grid x:Name="markGrid" Grid.Column="1" Margin="8 0 0 0" Width="44" Height="20"
                                  VerticalAlignment="Center"
								  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}">
                                <Border x:Name="normalBorder" Opacity="1" BorderThickness="2" CornerRadius="10"
										BorderBrush="{TemplateBinding BorderBrush}" Background="{StaticResource RadioButton.Static.Background}"/>
                                <Border x:Name="checkedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource  RadioButton.Checked.Border}" Background="{StaticResource RadioButton.Checked.Background}"/>
                                <Border x:Name="hoverBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.MouseOver.Border}" Background="{StaticResource RadioButton.MouseOver.Background}"/>
                                <Border x:Name="pressedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Pressed.Border}" Background="{StaticResource RadioButton.Pressed.Background}"/>
                                <Border x:Name="disabledBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Disabled.Border}" Background="{StaticResource RadioButton.Disabled.Background}"/>
                                <Ellipse x:Name="optionMark"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Static.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="-12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                                <Ellipse x:Name="optionMarkOn" Opacity="0"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Checked.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                            </Grid>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="TextBlockStyle" TargetType="{x:Type TextBlock}">
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="TextOptions.TextFormattingMode" Value="Display"/>
        </Style>
        
        <Style x:Key="ItemTitleStyle" TargetType="{x:Type TextBlock}" BasedOn="{StaticResource TextBlockStyle}">
            <Setter Property="Margin" Value="1"/>
            <Setter Property="FontSize" Value="16"/>
        </Style>

        <Style x:Key="ItemSubTitleStyle" TargetType="{x:Type TextBlock}" BasedOn="{StaticResource ItemTitleStyle}">
            <Style.Triggers>
                <DataTrigger Binding="{Binding RelativeSource={RelativeSource AncestorType=ToggleButton}, Path=IsChecked}" Value="True">
                    <Setter Property="Text" Value="On: Banners, Sound"/>
                    <Setter Property="Foreground" Value="{DynamicResource {x:Static SystemColors.GrayTextBrushKey}}"/>
                </DataTrigger>
                <DataTrigger Binding="{Binding RelativeSource={RelativeSource AncestorType=ToggleButton}, Path=IsChecked}" Value="False">
                    <Setter Property="Text" Value="Off"/>
                    <Setter Property="Foreground" Value="{DynamicResource {x:Static SystemColors.GrayTextBrushKey}}"/>
                </DataTrigger>
            </Style.Triggers>
        </Style>

        <SolidColorBrush x:Key="Hover.Enter.Brush" Color="#FFF2F2F2" />
        <SolidColorBrush x:Key="Hover.Exit.Brush" Color="#01FFFFFF" />

        <Storyboard x:Key="Hover.Enter.Storyboard">
            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background">
                <DiscreteObjectKeyFrame KeyTime="0:0:0" Value="{StaticResource Hover.Enter.Brush}" />
            </ObjectAnimationUsingKeyFrames>
        </Storyboard>

        <Storyboard x:Key="Hover.Exit.Storyboard">
            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background">
                <DiscreteObjectKeyFrame KeyTime="0:0:0" Value="{StaticResource Hover.Exit.Brush}" />
            </ObjectAnimationUsingKeyFrames>
        </Storyboard>

        <Style x:Key="HoverBorder" TargetType="Border">
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Margin" Value="0 4"/>
            <Setter Property="Padding" Value="10 2"/>
            <Style.Triggers>
                <EventTrigger RoutedEvent="Mouse.MouseEnter">
                    <BeginStoryboard Storyboard="{StaticResource Hover.Enter.Storyboard}" />
                </EventTrigger>
                <EventTrigger RoutedEvent="Mouse.MouseLeave">
                    <BeginStoryboard Storyboard="{StaticResource Hover.Exit.Storyboard}" />
                </EventTrigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="IconBorder" TargetType="Border">
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Margin" Value="0 0 10 0"/>
            <Setter Property="Padding" Value="4"/>
            <Setter Property="Width" Value="40"/>
            <Setter Property="Height" Value="40"/>
            <Setter Property="Background" Value="{StaticResource RadioButton.Checked.Background}"/>
        </Style>
        
    </Window.Resources>

    <ScrollViewer VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="20"/>
                <ColumnDefinition Width="520"/>
                <ColumnDefinition Width="20"/>
                <ColumnDefinition Width="240"/>
                <ColumnDefinition Width="20"/>
            </Grid.ColumnDefinitions>
            <!--#region Setting Panels-->
            <StackPanel Orientation="Vertical" Grid.Column="1">
                <!--#region Privacy & Telemetry Setting-->
                <StackPanel Orientation="Horizontal" Height="40">
                    <Viewbox Width="24" Height="24" VerticalAlignment="Center">
                        <Path Data="M12 5.69L17 10.19V18H15V12H9V18H7V10.19L12 5.69M12 3L2 12H5V20H11V14H13V20H19V12H22L12 3Z" Fill="Black" />
                    </Viewbox>
                    <TextBlock Text="Privacy &amp; Telemetry" FontSize="18" FontWeight="Medium" VerticalAlignment="Center" Margin="10 0 0 0"/>
                </StackPanel>

                <Grid Margin="0 10 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry0" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Turn off &quot;Connected User Experiences and Telemetry&quot; service" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry0, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry0, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <Grid Margin="0 20 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry1" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Turn off per-user services" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry1, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry1, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <Grid Margin="0 20 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry2" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Turn off the Autologger session at the next computer restart" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry2, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry2, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <Grid Margin="0 20 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry3" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Turn off the SQMLogger session at the next computer restart" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry3, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry3, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <Grid Margin="0 20 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry4" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Set the operating system diagnostic data level to &quot;Basic&quot;" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry4, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry4, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <Grid Margin="0 20 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry5" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Turn off Windows Error Reporting" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry5, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry5, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <Grid Margin="0 20 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry6" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Change Windows Feedback frequency to &quot;Never&quot;" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry6, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry6, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <Grid Margin="0 20 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry7" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Turn off diagnostics tracking scheduled tasks" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry7, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry7, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <Grid Margin="0 20 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry8" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Do not offer tailored experiences based on the diagnostic data setting" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry8, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry8, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <Grid Margin="0 20 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry9" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Do not let apps on other devices open and message apps on this device" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry9, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry9, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <Grid Margin="0 20 0 0" HorizontalAlignment="Left">
                    <ToggleButton x:Name="PrivacyAndTelemetry10" FontFamily="Sergio UI" FontSize="16"
                          Style="{DynamicResource ToggleSwitchTopStyle}"
                          Content="Do not allow apps to use advertising ID" 
                          IsChecked="False" 
                          />
                    <TextBlock Margin="52 0 0 0" VerticalAlignment="Bottom" FontFamily="Sergio UI" FontSize="16">
                        <TextBlock.Style>
                            <Style TargetType="TextBlock" BasedOn="{StaticResource TextBlockStyle}">
                                <Setter Property="Text" Value="Off" />
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry10, Path=IsChecked}" Value="True">
                                        <Setter Property="Text" Value="On" />
                                    </DataTrigger>
                                    <DataTrigger Binding="{Binding ElementName=PrivacyAndTelemetry10, Path=IsEnabled}" Value="false">
                                        <Setter Property="Opacity" Value="0.2" />
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </TextBlock.Style>
                    </TextBlock>
                </Grid>
                <!--#endregion-->
            </StackPanel>
            <!--#endregion-->
        </Grid>
    </ScrollViewer>
</Window>
'@

$xamlGui = [System.Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $xamlMarkup))
$xamlGui.ShowDialog()
