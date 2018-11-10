package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;

public class DAO {

	protected final DataSource myDataSource;

	/**
	 *
	 * @param dataSource la source de données à utiliser
	 */
	public DAO(DataSource dataSource) {
		this.myDataSource = dataSource;
	}


	/**
	 * Détruit un enregistrement dans la table DISCOUNT_CODE
	 * @param discountID la clé du code de promotion à détruire
	 * @return le nombre d'enregistrements détruits (1 ou 0 si pas trouvé)
	 * @throws DAOException
	 */
	public int deleteDiscountCode(char discountID) throws DAOException {
		String sql = "DELETE FROM DISCOUNT_CODE WHERE DISCOUNT_CODE = ?";
                
		try (   Connection connection = myDataSource.getConnection();
			PreparedStatement stmt = connection.prepareStatement(sql)
                ) {
			stmt.setString(1, String.valueOf(discountID));
			
			return stmt.executeUpdate();

		}  catch (SQLException ex) {
			Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
			throw new DAOException(ex.getMessage());
		}
	}
        
        
        
        /**
         * Ajoute un enregistrement dans la table DISCOUNT_CODE
         * @param discountID la clé du code de promotion à ajouter
         * @param taux le taux de réduction en pourcentage
         * @return le nombre d'enregistrements ajoutés (1 ou 0 si pas trouvé)
         * @throws DAOException 
         */
	public int addDiscountCode(char discountID, float taux) throws DAOException {
            String sql = "INSERT INTO DISCOUNT_CODE VALUES (?, ?)";
            
            try (   Connection connection = myDataSource.getConnection();
                    PreparedStatement stmt = connection.prepareStatement(sql)
            ) {

                    stmt.setString(1, String.valueOf(discountID));
                    stmt.setFloat(2, taux);

                    return stmt.executeUpdate();

            }  catch (SQLException ex) {
                    Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
                    throw new DAOException(ex.getMessage());
            }
	}
        
        public List<DiscountCodeEntity> getFullTable() throws DAOException{
            ArrayList<DiscountCodeEntity> table = new ArrayList<>();
            String sql = "SELECT * FROM DISCOUNT_CODE";
            try (   Connection connection = myDataSource.getConnection();
                    Statement stmt = connection.createStatement();
            ) {
                    ResultSet rs = stmt.executeQuery(sql);
                    while(rs.next()){
                        char code = rs.getString("DISCOUNT_CODE").charAt(0);
                        float taux = rs.getFloat("RATE");
                        table.add(new DiscountCodeEntity(code, taux));
                    }




            }  catch (SQLException ex) {
                    Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
                    throw new DAOException(ex.getMessage());
            }
            
            return table;
        }
	
        public List<Character> usedDiscountCodes() throws DAOException{
            ArrayList<Character> table = new ArrayList<>();
            String sql = "SELECT DISTINCT DISCOUNT_CODE FROM PRODUCT_CODE";
            try (   Connection connection = myDataSource.getConnection();
                    Statement stmt = connection.createStatement();
            ) {
                    ResultSet rs = stmt.executeQuery(sql);
                    while(rs.next()){
                        char code = rs.getString("DISCOUNT_CODE").charAt(0);
                        table.add(code);
                    }

            }  catch (SQLException ex) {
                    Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
                    throw new DAOException(ex.getMessage());
            }
            
            return table;
        } 
}
