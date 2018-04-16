Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Collections
Imports System.ComponentModel
Imports System.Web.SessionState

Public Class InvoiceItem
    Private owner As IList

    Private name_Renamed As String

    Private price_Renamed As Decimal

    Private quantity_Renamed As Integer

    Public Sub New(ByVal owner As IList)
        Me.owner = owner
        Me.price_Renamed = 0
        Me.quantity_Renamed = 1
    End Sub
    Public Property Name() As String
        Get
            Return name_Renamed
        End Get
        Set(ByVal value As String)
            name_Renamed = value
        End Set
    End Property
    Public Property Price() As Decimal
        Get
            Return price_Renamed
        End Get
        Set(ByVal value As Decimal)
            price_Renamed = value
        End Set
    End Property
    Public Property Quantity() As Integer
        Get
            Return quantity_Renamed
        End Get
        Set(ByVal value As Integer)
            quantity_Renamed = value
        End Set
    End Property
    Public ReadOnly Property Id() As Integer
        Get
            Return If(owner IsNot Nothing, owner.IndexOf(Me) + 1, -1)
        End Get
    End Property
    Public ReadOnly Property Total() As Decimal
        Get
            Return Price * Quantity
        End Get
    End Property
End Class

Public Class InvoiceItemsProvider
    Private ReadOnly Property Session() As HttpSessionState
        Get
            Return HttpContext.Current.Session
        End Get
    End Property

    Public Function GetItems() As BindingList(Of InvoiceItem)
        Dim items As BindingList(Of InvoiceItem) = TryCast(Session("InvoiceItems"), BindingList(Of InvoiceItem))
        If items Is Nothing Then
            items = New BindingList(Of InvoiceItem)()
            Session("InvoiceItems") = items
        End If
        Return items
    End Function
    Public Sub Populate()
        Dim rnd As New Random()
        Dim res As BindingList(Of InvoiceItem) = GetItems()
        For n As Integer = 0 To 9
            Dim item As New InvoiceItem(res)
            item.Name = "Item" & res.Count.ToString()

            item.Price = (CDec(rnd.Next(1, 1000))) / 10
            item.Quantity = rnd.Next(1, 5)
            res.Add(item)
        Next n
    End Sub
    Public Function GetItemById(ByVal id As Integer) As InvoiceItem
        For Each item As InvoiceItem In GetItems()
            If item.Id = id Then
                Return item
            End If
        Next item
        Return Nothing
    End Function
    Public Sub Delete(ByVal id As Integer)
        Dim item As InvoiceItem = GetItemById(id)
        If item IsNot Nothing Then
            GetItems().Remove(item)
        End If
    End Sub
    Public Sub Update(ByVal name As String, ByVal quantity As Integer, ByVal price As Decimal, ByVal id As Integer)
        Dim item As InvoiceItem = GetItemById(id)
        If item IsNot Nothing Then
            UpdateItem(item, name, quantity, price)
        End If
    End Sub
    Public Sub Insert(ByVal name As String, ByVal quantity As Integer, ByVal price As Decimal)
        Dim item As New InvoiceItem(GetItems())
        UpdateItem(item, name, quantity, price)
        GetItems().Add(item)
    End Sub
    Private Sub UpdateItem(ByVal item As InvoiceItem, ByVal name As String, ByVal quantity As Integer, ByVal price As Decimal)
        item.Name = name
        item.Quantity = quantity
        item.Price = price

    End Sub
End Class

