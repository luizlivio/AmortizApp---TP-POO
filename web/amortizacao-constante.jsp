<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/bootstrap-head.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AmortizApp - Amortização Constante</title>
        <style>
            tr {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div>
            <%@include file="WEB-INF/jspf/navbar.jspf" %>
            <%@include file="WEB-INF/jspf/form.jspf" %>
            <%DecimalFormat formatador = new DecimalFormat("#.##");%>
            
            <% try {
                double amortizacao = 0, totalAmortizado = 0, totalJuros = 0, totalPrestacao = 0, valorParcela = 0;
                double valorDivida = Double.parseDouble(request.getParameter("valorDivida"));
                int qtdParcelas = Integer.parseInt(request.getParameter("qtdParcelas"));
                double juros = Double.parseDouble(request.getParameter("taxaJuros"));
                double taxa = juros / 100;
                amortizacao = valorDivida / qtdParcelas;
                
                if((valorDivida > 0) && (qtdParcelas > 0) && (taxa > 0)){%>               
                    <table class="table">
                        <tr>
                            <th>Mês</th>
                            <th>Valor da Parcela</th>
                            <th>Valor dos Juros</th>
                            <th>Valor de Amortização</th>
                            <th>Saldo Devedor Total</th>
                        </tr>
                        <tr>
                            <td>0</td>
                            <td>-</td>
                            <td>-</td>
                            <td>-</td>
                            <td>R$ <%=formatador.format(valorDivida)%></td>
                        </tr>   
                        <%for (int i = 1; i <= qtdParcelas && valorDivida > 0; i++) {%>
                            <tr>     
                                <td><%=i%></td>
                                <%valorParcela = amortizacao + (valorDivida * taxa);%>
                                <td>R$ <%=formatador.format(valorParcela)%></td>
                                <%totalPrestacao = valorParcela + totalPrestacao;
                                juros = valorDivida * taxa;
                                totalJuros = juros + totalJuros;
                                totalAmortizado = amortizacao + totalAmortizado;%>
                                <td>R$ <%=formatador.format(juros)%></td>
                                <td>R$ <%=formatador.format(amortizacao)%></td>
                                <%valorDivida = valorDivida - amortizacao;%>
                                <td>R$ <%=formatador.format(valorDivida)%></td>              
                            </tr>
                        <%}%>
                        <tr style="font-weight: bold">               
                            <td> Total </td>
                            <td>R$ <%=formatador.format(totalPrestacao)%></td>
                            <td>R$ <%=formatador.format(totalJuros)%></td>
                            <td>R$ <%=formatador.format(totalAmortizado)%></td>
                            <td>  -  </td>
                        </tr>
                    </table>
                <%} else{
                        out.println("Valor inválido ou não informado!");
                    }
            } catch(Exception ex) {;
            }%>
        </div>
        <%@include file="WEB-INF/jspf/bootstrap-scripts.jspf" %>    
    </body>
</html>

