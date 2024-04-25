package com.javaweb.repository.custom.impl;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.builder.CustomerSearchBuilder;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.repository.custom.CustomerRepositoryCustom;
import org.springframework.context.annotation.Primary;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;
import java.util.stream.Collectors;
@Repository
@Primary
public class CustomerRepositoryImpl implements CustomerRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;
    public static void joinTable(CustomerSearchBuilder customerSearchBuilder, StringBuilder sql) {
        Long staffId = customerSearchBuilder.getStaffId();
        if(staffId != null) {
            sql.append("INNER JOIN assignmentcustomer ac ON c.id = ac.customerid ");
        }
    }

    public static void queryNormal(CustomerSearchBuilder customerSearchBuilder, StringBuilder where) {
        try {
            Field[] fields = CustomerSearchBuilder.class.getDeclaredFields();
            for(Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();
                if(!fieldName.equals("staffId")) {
                    Object value = item.get(customerSearchBuilder);
                    if(value != null) {
                        if(item.getType().getName().equals("java.lang.Long") ||  item.getType().getName().equals("java.lang.Integer")) {
                            where.append(" AND c." + fieldName + " = " + value + " ");
                        }
                        else if(item.getType().getName().equals("java.lang.String")) {
                            where.append(" AND c." + fieldName + " LIKE '%" + value + "%' ");
                        }
                    }
                }
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }
    public static void querySpecail(CustomerSearchBuilder customerSearchBuilder, StringBuilder where) {
        Long staffId = customerSearchBuilder.getStaffId();
        if(staffId != null) {
            where.append(" AND ac.staffid = " + staffId + " ");
        }
    }
    private StringBuilder buildQueryFilter(CustomerSearchBuilder customerSearchBuilder, Pageable pageable) {
        StringBuilder sql = new StringBuilder("SELECT c.* FROM customer c ");
        joinTable(customerSearchBuilder, sql);
        StringBuilder where = new StringBuilder("WHERE is_active = 1 ");
        queryNormal(customerSearchBuilder, where);
        querySpecail(customerSearchBuilder, where);
        where.append("GROUP BY c.id ");
        sql.append(where);
        return sql;
    }
    @Override
    public List<CustomerEntity> findCustomers(CustomerSearchBuilder customerSearchBuilder, Pageable pageable) {
        StringBuilder sql = buildQueryFilter(customerSearchBuilder, pageable);
        sql.append(" LIMIT ").append(pageable.getPageSize()).append("\n");
        sql.append(" OFFSET ").append(pageable.getOffset());
        Query query = entityManager.createNativeQuery(sql.toString(), CustomerEntity.class);
        return query.getResultList();
    }
    @Override
    public int countTotalItem(CustomerSearchBuilder customerSearchBuilder, Pageable pageable) {
        StringBuilder sql = buildQueryFilter(customerSearchBuilder, pageable);
        Query query = entityManager.createNativeQuery(sql.toString());
        return query.getResultList().size();
    }
}
